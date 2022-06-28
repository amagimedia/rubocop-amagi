# Amagi Rubocop CustomCop Rules

## How to use CustomCops?
***
**Using any cop**
---
Open .rubocop.yml in your working directory and set the enabled option as true.

CustomCop/Copname:
<indentation>  Enabled: true

### About PutLoggerFormatCop
PutLoggerFormatCop ensures that the message format received on encountering **puts** is of the standard format "<module/class>#method_name:<space><message>". 
