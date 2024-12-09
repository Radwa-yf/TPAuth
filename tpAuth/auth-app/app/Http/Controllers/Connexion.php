<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Utilisateur;
use App\Models\Log;
use App\Models\Reactivation;
use App\Http\Controllers\Email;
use Firebase\JWT\JWT;


/* A FAIRE (fiche 3, partie 2, question 1) : inclure ci-dessous le use PHP pour la libriairie gérant l'A2F */

// A FAIRE (fiche 3, partie 3, question 4) : inclure ci-dessous le use PHP pour la libriairie gérant le JWT

class Connexion extends Controller
{
    public function afficherFormulaireConnexion() {
        return view('formulaireConnexion', []);
    }

    public function afficherFormulaireVerificationA2F() {
        if(session()->has('connexion')) {
            if(Utilisateur::where("idUtilisateur", session()->get('connexion'))->count() > 0) {
                return view('formulaireA2F', []);
            }
            else {
                session()->forget('connexion');
                return view('formulaireConnexion', []);
            }
        }
        else {
            return view('formulaireConnexion', []);
        }
    }

    public function reactivationCompte() {
        $validation = false; // Booléen vrai/faux si les conditions de vérification sont remplies pour réactiver le compte
        $messageAAfficher = null; // Contient le message d'erreur ou de succès à afficher


        /* A FAIRE (fiche 3, partie 1, question 4) : vérification du code dans l'URL ainsi que de l'expiration du lien + réactivation du compte */
        $code = $_GET["code"];
    
    
        if (Reactivation::existeCode($code)) {
            $ligneReactivation = Reactivation::where("codeReactivation", $code)->first();
    
            
            if (Reactivation::estValide($code)) {
                $utilisateur = Reactivation::getUtilisateurConcerne($code);
    
                // Réactivation du compte utilisateur
                $utilisateur->reactiverCompte();  
    
                // Suppression du code de réactivation de la base de données
                $ligneReactivation->supprimerReactivation();
    
                // Enregistrement du log de réactivation
                Log::ecrireLog($utilisateur->emailUtilisateur, "compte réactivé");
    
                // Message de confirmation à afficher
                $messageAAfficher = "Votre compte a été réactivé avec succès.";
                $validation = true;
            } else {
                // Le code de réactivation est expiré
                $messageAAfficher = "Le code de réactivation a expiré.";
            }
        } else {
            // Le code de réactivation n'existe pas
            $messageAAfficher = "Code de réactivation invalide.";
        }
    
        if($validation === false) {
            return view("pageErreur", ["messageErreur" => $messageAAfficher]);
        }
        else {
            return view('confirmation', ["messageConfirmation" => $messageAAfficher]);
        }
    }

    public function boutonVerificationCodeA2F() {
        $validationFormulaire = false; 
        $messagesErreur = array(); 

        /* A FAIRE (fiche 3, partie 2, question 1) : vérification du code A2F */
        $google2fa = new \PragmaRX\Google2FA\Google2FA();
        session_start();
        $utilisateur=Utilisateur::where("idUtilisateur", session()->get("connexion"))->first();
        if ($google2fa->verifyKey($utilisateur->secretA2FUtilisateur, $_POST["codeA2F"])) {
            session()->forget("connexion");
            $validationFormulaire=true;
        } else {
            $messagesErreur[] = "code erroné";
        }

        /* A FAIRE (fiche 3, partie 3, question 4) : générer un JWT une fois le code A2F validé + création du cookie + redirection vers la page de profil */
        if ($validationFormulaire) {
            $key = 'T3mUjGjhC6WuxyNGR2rkUt2uQgrlFUHx';
            $payload = [
                'name' => $utilisateur->emailUtilisateur,
                'sub' => $utilisateur->idUtilisateur,
                'iat' => time()
            ];
            $jwt = JWT::encode($payload, $key, 'HS256');
            setcookie('auth', $jwt, time() + 2592000, '/');
            
            // Redirection vers la page du profil :
            return redirect()->to('profil')->send();
        }else{
            return view("formulaireA2F", ["messageErreur"=> $messagesErreur]);
        }
    }
    
    public function boutonConnexion() {
        $validationFormulaire = false; // Booléen qui indique si les données du formulaire sont valides
        $messagesErreur = array(); // Tableau contenant les messages d'erreur à afficher
        $nbrTentatives=0 ; 
        /* A FAIRE (fiche 3, partie 1, question 3) : vérification du couple login/mot de passe */
        if(Utilisateur::existeEmail($_POST["email"])) {
            $utilisateur = Utilisateur::connexion($_POST["email"], $_POST["motdepasse"]);
            if ($utilisateur && Utilisateur::tentativesEchouees($_POST["email"]) < 5) {
                session()->put("connexion",$utilisateur->idUtilisateur)  ;
                $validationFormulaire=true ; 
                Log::ecrireLog($_POST["email"], "connexion");
                Utilisateur:: renitialisernTentatives($_POST["email"]);
                return view('formulaireA2F', []);
           }
           else{
                $validationFormulaire = false;
                Utilisateur::incrementerTentatives($_POST["email"]);
                $nbrTentativesRestantes=5-Utilisateur::tentativesEchouees($_POST["email"]);
                $messagesErreur[] = "Le mot de passe est incorrect il vous reste $nbrTentativesRestantes Tentatives !";
                Log::ecrireLog($_POST["email"], "Tentative de connexion échoué ");
                if (Utilisateur::tentativesEchouees($_POST["email"]) == 5) {
                    // Récupérer l'utilisateur pour désactiver le compte
                    $utilisateur = Utilisateur::where('emailUtilisateur', $_POST["email"])->first();
                
                    if ($utilisateur) {
                        $utilisateur->desactiverCompte();
                        $code = Reactivation::creerCodeReactivation($utilisateur);
                        $messagesErreur[] = "Votre compte est bloqué.";
                        Email::envoyerEmail($_POST["email"], "Réactivation de compte", "http://172.17.0.9/reactivation?code=" . $code);
                    } else {
                        $messagesErreur[] = "Erreur lors du blocage du compte : utilisateur introuvable.";
                    }
                }
                
            }
        }
           if($validationFormulaire === false) {
                return view('formulaireConnexion', ["messagesErreur" => $messagesErreur]);
            }
            else {
                return view('formulaireA2F', []);
            }
        }
        
    

    public function deconnexion() {
        if(session()->has('connexion')) {
            session()->forget('connexion');
        }
        if(isset($_COOKIE["auth"])) {
            setcookie("auth", "", time()-3600);
        }

        return redirect()->to('connexion')->send();
    }

    public function validationFormulaire() {
        if(isset($_POST["boutonVerificationCodeA2F"])) {
            return $this->boutonVerificationCodeA2F();
        }
        else {
            if(isset($_POST["boutonConnexion"])) {
                return $this->boutonConnexion();
            }
            else {
                return redirect()->to('connexion')->send();
            }
        }
    }
}