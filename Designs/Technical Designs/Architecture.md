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

Each node is in platform with a pole and a surface for the user to put the hand. A design of this can be seen here.

<iframe src="https://myhub.autodesk360.com/ue2c8672e/shares/public/SH56a43QTfd62c1cd9683c46dd617273f20f?mode=embed" ></iframe>

#### Top surface
The top surface is 43cmX40cmx3cm and it forms an angle of 30 degrees with the pole.

The top surface has:
* a heart-rate sensor. This sensor is connected to a microprocessor which in charge of the communication with the central processing component and control the other elements in the node.
* a light on the border. Those lights go up and down like breath.
* a vibration system that provide physical feedback to he user.

Once the user touches the top surface the lights go out and once the microprocessor has catch the heart signal it stars to vibrate with the average heart beat on the system. The light go then back on and the heart signal is reflected in the visualisation.

### Pole & Microprocessor

The pole is 1.5mx20cm and it i located one third from the edge of the base. It has a hole in the middle, for cables, and a compartment to hold the microprocessor.

The microprocessor has the following functionality
* Controls all the lights in the node.
* Reads the heart signal from the users
* Calculates the heart beat of the users
* Transmits the heart signal and heart beat to the central processing component.
* Retrieves the average heart beat from the central processing component.  
* Controls the vibration of the top surface.

### Base

The base has two steps. The lower step is a 1.5mx1.5mx20cm. The second step is 1mx1mx20cm. It has a light on the border.

The base has a hole in the middle to accommodate other elements. For example a power source or an internet connection. There is a small hole from the center to the side of the base. This can be used in case cables ned to go into or out of the node.

## Central Processing Component

to do

## Visualization component

to do
