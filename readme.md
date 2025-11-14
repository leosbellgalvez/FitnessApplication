APPLICATION SPECS
===

# Fitness Application

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

An application that keeps track of fitness goals and actual in-gym exercises. It allows for logging of sets and reps in exercises to monitor your activity. May feature a meal-planner generator.

### App Evaluation


- **Category:** Health / Fitness
- **Mobile:** Mobile is necessary for the easy access to logging of users health journey and exercises. Users use the app to monitor their sets/reps and health journey.
- **Story:**  Helps users stay on top of their exercise progress when working out and allowing for meal planning based on their input information enhancing their fitness journey.
- **Market:** Any gym-going individual upto gym coaches helping keep track of student progress. 
- **Habit:** Gym-goers are using this daily or whenever they are at the gym working out as well as when they need recommendations for meals based on the information they input about themselves.
- **Scope:** V1, one version, is all that is needed as it is for the user themselves and they control what they want to log or what not to log. It is flexible to their choice.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* User can login/signout with backend handled by parseswift and back4app
* User can input set/rep exercise information and it will log. 
* User can review log history to view previous work outs and monitor their health journey.
* User can delete logs if needed based on their specification
* User can edit logs if a mistake is made upon initial upload.

**Optional Nice-to-have Stories**

* User can input calories, and other information to use Spoonacular API and return a list of meal-plans for their health journey.

### 2. Screen Archetypes

- [ ] **Information Log Screen**
    * Required User Feature: User can input set/rep information
- [ ] **Log History Screen **
    * Required User Feature: User can delete/edit/view previously uploaded logs.
- [ ] **Meal Plan Input Info Screen**
    * Optional User feature: User can input calories and other information
- [ ] **Meal Plan Generated Screen**
    * Optional User Feature: After Meal Plan Input info, this screen generates the meal plan based on the specifications.


### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [ ] 🏋️ Exercise Logger
- [ ] 📖 Log History
- [ ] 🥗 Meal Plan Generator


**Flow Navigation** (Screen to Screen)

- [ ] **Home Screen**
  * Leads to Information Log Screen
  * Leads to Meal Plan Generator
- [ ] **Information Log Screen**
  * Leads to Log History Screen


## Wireframes

![72F3AF13-7613-4C81-9E1C-883E32754656 2](https://hackmd.io/_uploads/BJFMJCVg-g.jpg)





## Schema 


### Models

[Model Name, e.g., User]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |



### Networking


- Information Log Screen [POST] /log
- Log History Screen [Get] /logs
- Using Existing API: Meal Plan Generated Screen: [GET] https://api.spoonacular.com/mealplanner/generate
