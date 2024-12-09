<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Utilisateur extends Model
{
    protected $table = 'utilisateur';
    protected $primaryKey = 'idUtilisateur';
    public $timestamps = false;

    public function logs(): HasMany
    {
        return $this->hasMany(Log::class);
    }

    public static function existeEmail($email) {
        $nb = self::where("emailUtilisateur", $email)->count();

        if($nb > 0) {
            return true;
        }
        else {
            return false;
        }
    }

    public function desactiverCompte() {
        $this->estDesactiveUtilisateur = 1;
        $this->save();
    }

    public function reactiverCompte() {
        $this->estDesactiveUtilisateur = 0;
        $this->tentativesEchoueesUtilisateur = 0;
        $this->save();
    }

    public static function inscription($email, $motDePasseHache, $nom, $prenom, $secretA2F) {
        $nouvelUtilisateur = new Utilisateur();
        $nouvelUtilisateur->emailUtilisateur = $email;
        $nouvelUtilisateur->motDePasseUtilisateur = $motDePasseHache;
        $nouvelUtilisateur->nomUtilisateur = $nom;
        $nouvelUtilisateur->prenomUtilisateur = $prenom;
        $nouvelUtilisateur->secretA2FUtilisateur = $secretA2F;

        $nouvelUtilisateur->save();
    }
    public static function connexion($email, $motDePasse){

        $utilisateur = Utilisateur::where('emailUtilisateur', $email)->first();
        if ($utilisateur && password_verify($motDePasse,$utilisateur->motDePasseUtilisateur)) {
            return $utilisateur ;
        } 
        else{
            return null ; 
        } 
    }
    public static function tentativesEchouees($email){
        return Utilisateur::where('emailUtilisateur', $email)->value('tentativesEchoueesUtilisateur');
       
    }
    public static function renitialisernTentatives($email){
        return Utilisateur::where('emailUtilisateur', $email)->update(['tentativesEchoueesUtilisateur' => 0]);
       
    }
    public static function incrementerTentatives($email) {
    
        Utilisateur::where('emailUtilisateur', $email)->increment('tentativesEchoueesUtilisateur');
    }
    
}