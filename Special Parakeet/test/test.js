// require("@babel/register");

//  import {
//   assertFails,
//   assertSucceeds,
//   initializeTestEnvironment,
//   RulesTestEnvironment,
// } from "@firebase/rules-unit-testing"

// import { createRequire } from "module";

// const require = createRequire(import.meta.url);

// const rulesTestEnvironment = require("@firebase/rules-unit-testing")

import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from "@firebase/rules-unit-testing"

let testEnv = await initializeTestEnvironment({
  projectId: "special-parakeet",
  firestore: {
    rules: fs.readFileSync("special-parakeet-firestore.rules", "utf8"),
  },
});

import { setDoc } from "firebase/firestore";

const context = testEnv.unauthenticatedContext();

test("Test simulated write by an unauthenticated user", async () => {
	await assertSucceeds(setDoc(context.firestore().collection("isFavorited"), "Sparrow"), { "name": "Sparrow", "isFavorited": true });
    // await assertSucceeds(setDoc(context.firestore(), '/isFavorited/Sparrow'), { "name": "Sparrow", "isFavorited": true });
});