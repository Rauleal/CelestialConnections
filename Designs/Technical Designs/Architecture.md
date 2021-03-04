# System Designs

This page contains the technical system designs for the Celestial Connections project.

In the project for each visualisation there is an associated system. Each of sech system has the following components.

* An user input components.
* A central processing component.
* A visualisation component.

The functionality and design of each components is as follows

## User Input components

These are the basic interfaces of the user with the system.

The main functionality of this is to collect the heart-rate data of the users and transmit into the system.
Each visualisation system can have several independent user input components. We call each of those individual components an *input node* or just *node*.

### Input Node design & interaction

Each node is in platform with a pole
where users can

<iframe src="https://myhub.autodesk360.com/ue2c8672e/shares/public/SH56a43QTfd62c1cd9683c46dd617273f20f?mode=embed" ></iframe>

A second functionality of this component is to provide physical feedback to the user. This is done by means of light and retrieve the average heart-rate from the
