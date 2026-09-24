*** Settings ***
Documentation    Test cases for piper-tts snap
Resource         kvm.resource


*** Test Cases ***
Piper Tts Launches And Renders
    [Documentation]    Verify piper-tts snap launches and renders a UI on Mir
    [Tags]    smoke    yarf:certification_status: blocker
    Log Screenshot
