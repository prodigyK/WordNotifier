const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.myFunction = functions.firestore
    .document("devices/{docId}")
    .onUpdate((change, context) => {
      console.log(change.before.ref.id);
      console.log(change.after.data().topic);
      admin.messaging().sendToTopic(
          change.after.data().topic, {
            notification: {
              title: "Learn words",
              body: change.after.data().isEnabled.toString(),
            },
          });
    });
