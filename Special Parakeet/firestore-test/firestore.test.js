/**
 * @jest-environment node
 */

const { initializeTestEnvironment, assertSucceeds, assertFails} = require("@firebase/rules-unit-testing");
const { doc, getDoc } = require("firebase/firestore");
const fs = require('fs');

const testRules = async () => {
    const testEnv = await initializeTestEnvironment({
        projectId: "special-parakeet",
        firestore: {
            rules: fs.readFileSync("special-parakeet-firestore.rules", "utf8"),
            host: "localhost", // Required to run in the emulator in case it’s not automatically detected!
            port: 8080
        },
    });
    firebase.assertSucceeds(app.firestore().collection("isFavorited").doc("bird").get());
    // const context = await testEnv.authenticatedContext("id_alice");
    // return await assertSucceeds(getDoc(doc(context.firestore(), "users", "id_alice")));
}

test("Simulated read is allowed by Firebase rules", async () => {
    await expect(testRules()).resolves.toBeDefined(); // assertSucceeds promise is resolved since rules allowed it
});

// import {
//   assertFails,
//   assertSucceeds,
//   initializeTestEnvironment,
//   RulesTestEnvironment,
// } from "@firebase/rules-unit-testing"

// let testEnv = await initializeTestEnvironment({
//   projectId: "special-parakeet",
//   firestore: {
//     rules: fs.readFileSync("special-parakeet-firestore.rules", "utf8"),
//   },
// });

// firebase.assertSucceeds(app.firestore().collection("isFavorited").doc("bird").get());
