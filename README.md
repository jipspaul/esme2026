# esme26

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# esme2026

## Modeles metier : particuliers et artisans

Les classes sont dans [`lib/domain/models/`](lib/domain/models/).
Import global disponible :

```dart
import 'package:esme26/domain/models/models.dart';
```

### Clean Architecture

- `domain/models` : entites et objets-valeurs Dart purs, sans Flutter, JSON,
  Firebase ni dependance vers `data` ou `ui`.
- `data/models` : les anciens imports de `User` et `Adress` restent disponibles
  par reexport, sans dupliquer les classes. Les futurs DTO et conversions
  JSON/API/base de donnees doivent vivre dans cette couche, pas dans le domaine.
- Les contrats de repositories et les cas d'utilisation futurs appartiennent
  au domaine ; leurs implementations appartiennent a `data/repositories`.
  Les repositories existants ne sont pas restructures par cet ajout.

### Catalogue

| Fichier | Modeles et usage |
| --- | --- |
| `user.dart`, `customer_profile.dart` | Compte, roles particulier/artisan cumulables, profil particulier |
| `artisan_profile.dart` | Entreprise, immatriculation, metiers, tarifs et zones d'intervention (`ServiceArea`) |
| `adress.dart`, `geo_point.dart` | Adresse et coordonnees ; orthographe `Adress` conservee pour compatibilite |
| `trade.dart` | Catalogue hierarchique de metiers et specialites |
| `professional_document.dart` | Immatriculation, qualifications, assurances et verification |
| `portfolio_project.dart` | Realisations de l'artisan et medias |
| `attachment.dart` | Metadonnees des photos, videos et documents |
| `work_request.dart` | Demande de travaux, lieu, budget, urgence et periode souhaitee |
| `quote.dart` | Devis, lignes (`QuoteLine`), quantites, unites et TVA |
| `job.dart` | Chantier issu d'un devis accepte, montant convenu et planification |
| `appointment.dart`, `availability.dart` | Rendez-vous de visite et plages de disponibilite |
| `conversation.dart`, `message.dart` | Discussion particulier/artisan, messages et pieces jointes |
| `review.dart` | Avis lie a un chantier, note de 1 a 5 et reponse de l'artisan |
| `invoice.dart` | Facture et lignes tarifaires figees |
| `payment.dart` | Paiement, acompte/solde et remboursements (`Refund`) |
| `dispute.dart` | Litige de chantier et justificatifs |
| `favorite.dart`, `app_notification.dart` | Artisans favoris et notifications |
| `money.dart`, `time_slot.dart` | Montant (`Money`), fourchette de budget (`Budget`) et periode |

### Relations et regles

- Les relations utilisent des identifiants, sans graphe d'objets cyclique :
  `User` -> profils ; `WorkRequest` -> `Quote` -> `Job` -> `Invoice` ->
  `Payment` -> `Refund`. `artisanId` et `customerId` designent des `User.id`.
  `ProfessionalDocument`, `PortfolioProject` et `Availability` sont rattaches
  a l'artisan ; `Message` a une `Conversation`.
- Les identifiants sont attribues par les futurs services/repositories.
  Seul `User.id` est nullable pour conserver l'inscription existante avant
  persistance. Les dates ne sont pas generees implicitement ; utiliser UTC aux
  frontieres de persistance. Le champ historique de naissance reste en
  millisecondes depuis l'epoch.
- Champs `final`, listes et ensembles copies et non modifiables.
  Les erreurs locales (montant negatif, devis vide, devis multidevise,
  periode inversee, coordonnees invalides, message vide, etc.) provoquent
  une `ArgumentError`, y compris en production.
- `Money.minorUnits` utilise des entiers (centimes pour EUR), jamais un prix
  en `double`. Une quantite de ligne peut etre fractionnaire. Le sous-total
  est arrondi au centime par ligne ; la TVA en points de base
  (`2000` = 20 %) est arrondie par ligne au plus proche, demi vers le haut.
  Les devis et factures reutilisent les memes lignes pour les calculs HT/TVA/TTC.
  Le code devise est valide syntaxiquement, sans catalogue ISO embarque.
- Les objets ne prouvent pas l'autorisation ni l'existence des relations.
  Les cas d'utilisation/backend devront controler les roles, transitions
  de statut, chevauchements de disponibilites, devis accepte, unicite d'avis
  par chantier termine, montants de paiements/remboursements et validite
  des assurances. Les modeles n'effectuent aucun paiement reel.
- Les etats financiers sont mis a jour par le backend/prestataire de paiement,
  jamais consideres comme fiables sur la seule declaration du client.
  Seules les references du prestataire sont conservees : aucune donnee de carte.
  Les droits d'acces aux adresses, documents et medias doivent etre controles
  par le backend ; aucune URL publique n'est imposee.

Validation ciblee :

```bash
dart analyze lib/domain/models lib/data/models test/domain/models
flutter test test/domain/models
```
