# Prod flavor – Firebase not configured yet

When the prod Firebase project exists, run from the repo root:

```
flutterfire configure -p <prod-project-id> --platforms=android \
  -a pl.jakubdkier.doghub \
  -o lib/core/firebase/firebase_options_prod.dart \
  --android-out=android/app/src/prod/google-services.json
```

Then set `googleServerClientId` in `lib/main_prod.dart` (web client id,
oauth_client with client_type 3 in google-services.json), add the release
SHA-1 to the prod Android app and add a `prod` alias in `.firebaserc`.
