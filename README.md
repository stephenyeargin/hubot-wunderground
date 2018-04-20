# Hubot Weather Underground 

[![npm version](https://badge.fury.io/js/hubot-wunderground.svg)](http://badge.fury.io/js/hubot-wunderground) [![Build Status](https://travis-ci.org/stephenyeargin/hubot-wunderground.png)](https://travis-ci.org/stephenyeargin/hubot-wunderground)

Get the latest weather from Weather Underground

See [`src/wunderground.coffee`](src/wunderground.coffee) for full documentation.

[Original work](https://github.com/github/hubot-scripts/blob/master/src/scripts/wunderground.coffee) by @alexdean and others.

## Configuration

| Configuration Variable           | Required? | Description                   |
| -------------------------------- | :-------: | ----------------------------- |
| `HUBOT_WUNDERGROUND_API_KEY`     | Yes       | API key from Wunderground     |
| `HUBOT_WUNDERGROUND_USE_METRIC`  | No        | Set to any value to use Celsius |

## Installation

In hubot project repo, run:

`npm install hubot-wunderground --save`

Then add **hubot-wunderground** to your `external-scripts.json`:

```json
[
  "hubot-wunderground"
]
```

## Sample Interaction

```
User> @hubot weather in nashville tn
Hubot> Friday in nashville tn: Clear. Lows overnight in the low 60s. (7199)
```

## NPM Module

https://www.npmjs.com/package/hubot-wunderground
