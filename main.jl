# Copyright 2019 Jeykey
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#Project Euler Problem 109
#=
In the game of darts a player throws three darts at a target board which is split into twenty equal sized sections numbered one to twenty.
The score of a dart is determined by the number of the region that the dart lands in. A dart landing outside the red/green outer ring scores zero. The black and cream regions inside this ring represent single scores. However, the red/green outer ring and middle ring score double and treble scores respectively.
At the centre of the board are two concentric circles called the bull region, or bulls-eye. The outer bull is worth 25 points and the inner bull is a double, worth 50 points.
There are many variations of rules but in the most popular game the players will begin with a score 301 or 501 and the first player to reduce their running total to zero is a winner. However, it is normal to play a "doubles out" system, which means that the player must land a double (including the double bulls-eye at the centre of the board) on their final dart to win; any other dart that would reduce their running total to one or lower means the score for that set of three darts is "bust".
When a player is able to finish on their current score it is called a "checkout" and the highest checkout is 170: T20 T20 D25 (two treble 20s and double bull).

There are exactly eleven distinct ways to checkout on a score of 6:

D3
D1 	D2 	 
S2 	D2 	 
D2 	D1 	 
S4 	D1 	 
S1 	S1 	D2
S1 	T1 	D1
S1 	S3 	D1
D1 	D1 	D1
D1 	S2 	D1
S2 	S2 	D1

Note that D1 D2 is considered different to D2 D1 as they finish on different doubles. However, the combination S1 T1 D1 is considered the same as T1 S1 D1.
In addition we shall not include misses in considering combinations; for example, D3 is the same as 0 D3 and 0 0 D3.
Incredibly there are 42336 distinct ways of checking out in total.
How many distinct ways can a player checkout with a score less than 100?
=#

using Printf
using Statistics

#List of all the possible numbers in a game of dart
global posNums = []
#List of all the starting (ending) values  (doubles)
global doubleNums = []

#Function to fill the array with all the possible numbers, no return value
function fillArray()
    for i = 1:20
        push!(posNums, i)
        push!(posNums, i * 2)
        push!(posNums, i * 3)
        #Also push to doubleNums array, for the starting values
        push!(doubleNums, i * 2)
    end
    #Special case for the middle two
    middle = 25
    push!(posNums, middle)
    push!(posNums, middle * 2)
    #Add also to the starting values list
    push!(doubleNums, middle * 2)
end

#Function for all the checkout ways with only one step
function oneStep()
    withOneStep = 0
    for i in doubleNums
        withOneStep += 1
    end
    return withOneStep
end

#Function for all the checkout ways with two steps
function twoSteps()
    withTwoSteps = 0
    #Loop through both arrays at once
    for i in doubleNums, j in posNums
        #Only use combinations where the sum of both is less than 100
        if i + j >= 100
            continue
        else
            withTwoSteps += 1
        end
    end
    return withTwoSteps
end

#Function for all the checkout ways with three steps
function threeSteps()
    withThreeSteps = 0
    #Loop through the doubleNums array once, and through all the numbers twice
    for i in doubleNums, j in posNums, k in posNums
        #Only use combinations where the sum of all three of them is less than 100
        if i + j + k >= 100
            continue
        else
            withThreeSteps += 1
        end
    end
    return withThreeSteps
end

#Main function, only function, that calls other function
function main()
    # Step 1: Fill both arrays with the possible values
    fillArray()
    # Step 2: Check for all the diffrent 
    result1 = oneStep()
    result2 = twoSteps()
    result3 = threeSteps()
    finalResult = result1 + result2 + result3
    println("Final result: ", finalResult)
end

##########
main()