// googleAuthService.js

import firebase from 'firebase/app';
import 'firebase/auth';

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID"
};

// Initialize Firebase
if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
}

// Google Sign-In - Function to handle sign in
export const googleSignIn = async () => {
    const provider = new firebase.auth.GoogleAuthProvider();
    try {
        const result = await firebase.auth().signInWithPopup(provider);
        const user = result.user;
        console.log('User signed in: ', user);
        return user;
    } catch (error) {
        console.error('Error during Google Sign-In: ', error);
        throw error;
    }
};

// Sign-out function
export const signOut = async () => {
    try {
        await firebase.auth().signOut();
        console.log('User signed out successfully.');
    } catch (error) {
        console.error('Error during sign out: ', error);
    }
};

// Monitor auth state changes
export const onAuthStateChanged = (callback) => {
    return firebase.auth().onAuthStateChanged(callback);
};
