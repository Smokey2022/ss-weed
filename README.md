# ss-weed

Weed picking and processing script

- [My city's discord](https://discord.gg/nAKEcGS2pp)

🔴 Made for the qbcore Framework
- [GitHub](https://github.com/qbcore-framework) / [DISCORD](https://www.discord.gg/qbcore)


Thank you for your interest in my work.
Please consider supporting ❤
- [Paypal ME](https://paypal.me/smokeyscripts22?country.x=US&locale.x=en_US)
- [My TEBEX STORE](https://smokey-scripts.tebex.io/)

## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [qb-drugs](https://github.com/qbcore-framework/qb-drugs)

## Installation
### Manual
1. Place ss-weed in you're server recources folder and add it to the server.cfg

2. Add these lines below to: qb-core/shared.lua under QBShared.Items
#
	["skunk"] 				 	 = {["name"] = "skunk", 			  			["label"] = "Raw Skunk", 						["weight"] = 100, 	["type"] = "item", 		["image"] = "skunk.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Raw skunk weed!"},
	["weed_skunk"] 				 	 = {["name"] = "weed_skunk", 			  			["label"] = "Skunk 2g", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "weed_skunk.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Strong weed!"},
	["coke_empty_bags"] 				 	 	 = {["name"] = "coke_empty_bags", 			  			["label"] = "Empty Bags", 					["weight"] = 100, 		["type"] = "item", 		["image"] = "coke_empty_bags.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Ziploc bags!"},
["trowel"] = {['name'] = 'trowel',['label'] = 'Trowel', ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'trowel.png', 						['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Small handheld garden shovel'},

3. Add the images (in ss-weed/imgs) to qb-inventory/html/images

4. Go to ss-weed/client.lua line  52 and change the box zone to where you want to process the weed (by default it requires a custom MLO)

5. Add weed_skunk to qb-drugs/config.lua to sell to npc

6. Change the location of the field in ss-weed/config.lua (this is where the plants spawn) 

3. start/restart you're server

## Usage
In you're server give yourself the items above:
1x trowel
2x coke_empty_bags

Then tp to these coords to pick the weed (2835.75, 4647.75, 47.27)

Then go to the box zone in which you set the processing

1 raw skunk will make 2 bags. 


# Licence
2022 Smokey Scripts

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>
