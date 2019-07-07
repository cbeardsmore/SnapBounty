const firestoreService = require('firestore-export-import');
const serviceAccount = require('./snapbountykey.json');
 
firestoreService.initializeApp(serviceAccount, 'https://snap-hero-1.firebaseio.com');
 
firestoreService
  .backup('challenges')
  .then(data => console.log(JSON.stringify(data)))