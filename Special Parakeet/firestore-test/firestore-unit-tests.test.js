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

RulesTestEnvironment.withSecurityRulesDisabled

import { setDoc } from "firebase/firestore";

const context = testEnv.unauthenticatedContext();

test("Test simulated write by an unauthenticated user", async () => {
    await assertSucceeds(setDoc(context.firestore(), '/isFavorited/Sparrow'), { "name": "Sparrow", "isFavorited": true });
});