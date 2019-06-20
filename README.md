# Breathe Project

This is the final team engineering project at Makers. We decided to create an iOS app that features an interactive map of various cities around the world that a user can navigate to and view a set of pollution data about the subareas within them. Our goal for this is to build an accessible app that helps an everyday user understand the environmental conditions of the area they're travelling through.

## Team

- [Yadira Sanchez](https://github.com/yadlra)
- [Kiah Hewitt](https://github.com/kiahjade)
- [Xain Storey](https://github.com/Xa1n)
- [Callum Marshall](https://github.com/callum-marshall)


## Architecture/Domain Model

![alt text](https://github.com/callum-marshall/Breathe/blob/master/MVC-Architecture.png)

## How to install

Clone this repository:
```
git clone https://github.com/callum-marshall/Breathe.git
```
Cd to the repo in your terminal and install the dependencies with Pod:
```
pod install
```
Once the installation is finished, open the project in Xcode (please install it if you don't have it):
```
open Breathe.xcworkspace
```
**OR**
```
xed .
```
To run the tests, navigate to the top left of Xcode (as seen below) and click the play button, or press 'Cmd(⌘) + U'

## Screenshots

![alt text](https://github.com/callum-marshall/Breathe/blob/master/Test_Instruction.png)


## Tech Stack

- Swift

## User Stories

```
MVP 

As a concerned Londoner,
So that I can easily access information about pollution in London,
I would like an app that I can use on my smartphone.

As a concerned Londoner,
So that I can see the different levels of pollution in London,
I would like to be able to see a map of my city.

As a concerned Londoner,
So that I can identify areas of varying levels of pollution,
I would like to see the air quality displayed on the map.


As a concerned Londoner,
So that I can avoid areas of low air quality,
I would like to be able to see where I am on the map.

```

## Our vision going forward

- More cities and general data for countries

- Replacing annotations with tiles

- Getting pollution data on user's exact location

- Navigation system for avoiding high-pollution areas

- Colour coding the data - using indexes for individual pollutants

- Providing resources in app for user to learn more about pollution and how they can get involved in climate action

- Showing other social data relative to pollution (e.g. how social segregation worsens climate change)
