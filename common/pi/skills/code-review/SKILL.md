---
name: code-review
description: >
  Review code for correctness, clarity, performance, and maintainability with categorised feedback.
---
 
## Procedure
 
1. **Understand the change:**
   - Read the PR description and linked ticket first
   - What problem does this solve? What's the expected behaviour?
   - Is the approach appropriate for the problem scope?
 
2. **Correctness:**
   - Does it do what it claims? Trace logic for happy path and edge cases
   - Are error cases handled? What happens with nil/null/empty/boundary inputs?
   - Are there race conditions? (Shared state, concurrent access, async operations)
 
3. **Clarity:**
   - Can you understand the code without the author explaining it?
   - Are names (functions, variables, types) descriptive and consistent?
   - Are there unnecessary abstractions or premature generalisations?
 
4. **Performance:**
   - N+1 queries? Unbounded loops? Missing pagination?
   - Are expensive operations cached, batched, or deferred where appropriate?
 
5. **Maintainability:**
   - If requirements change slightly, how much of this breaks?
   - Is test coverage adequate for the risk level?
   - Does this introduce tech debt? If so, is it documented?
 
6. **Categorise each comment:**
   - **Blocking:** must fix before merge
   - **Recommendation:** strongly suggest but won't block
   - **Nit:** optional improvement
   - **Question:** need to understand intent
   - **Praise:** something done well

## esp-rs repositories

When reviewing repositories under the `esp-rs` organization, also keep these points in mind:

- Some PRs require hardware for proper verification. Ask the user to plug in the required hardware when needed, and ask them to run hardware-specific tests if you cannot run them directly.
- For `esp-rs/esp-hal`, consult the technical documentation at https://github.com/esp-rs/esp-hal/tree/main/documentation. Much of it also applies to other `esp-rs` repositories.
- When reviewing `esp-rs/esp-hal`, it can also be useful to consult the relevant chip's Technical Reference Manual (TRM), available from https://www.espressif.com/en/support/documents/technical-documents, as well as the ESP-IDF documentation or implementation at https://espressif-docs.readthedocs-hosted.com/projects/esp-idf/en/latest/ and https://github.com/espressif/esp-idf.
- For `esp-hal` crate documentation, use https://docs.espressif.com/projects/rust/index.html. For other crates, use their official docs on `docs.rs`.
- When reviewing PRs in `espflash`, feel free to ask the user to verify behaviour on real hardware as part of the review. It can also be useful to compare its behaviour with `esptool`, using https://github.com/espressif/esptool and the corresponding chip-specific documentation under https://docs.espressif.com/projects/esptool/en/latest/ (for example, `esp32c3/index.html` for ESP32-C3) as references.
 
## Output
 
Review comments on the PR/MR, each categorised. Summary comment with: overall assessment
(approve / request changes / needs discussion) and key points.
