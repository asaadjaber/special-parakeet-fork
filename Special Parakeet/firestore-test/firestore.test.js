/**
 * @jest-environment node
 */

import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
  RulesTestEnvironment,
} from "@firebase/rules-unit-testing"

let testEnv = await initializeTestEnvironment({
  projectId: "special-parakeet",
  firestore: {
    rules: fs.readFileSync("special-parakeet-firestore.rules", "utf8"),
  },
});

firebase.assertSucceeds(app.firestore().collection("isFavorited").doc("bird").get());
