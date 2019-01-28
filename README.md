# The-Good-Bad-Code
Pushing the limits of bad programming practices. Abusing APIs. Destroying utility programs.

# Table of Contents
## ForceAdmin.asm<br/>
Abuseses the fact that UAC prompt (consent.exe) doesn't allow the user to do anything besides answer the question. We can see what the user presses and if they don't select yes, then we ask again. This endless loop traps the user and "forces" them to click yes.
