import React from 'react'
import ReactDOM from 'react-dom'
import merge from 'lodash/merge'
import mapValues from 'lodash/mapValues'

// To spawn an <Example /> react component:
// <div data-component="Example"></div>

// To spawn an Example behavior:
// <div data-behavior="Example"></div>

const tryAsJson = (thing) => {
    try {
      let result = JSON.parse(thing)
        // Handle non-exception-throwing cases:
        // Neither JSON.parse(false) or JSON.parse(1234) throw errors, hence the type-checking,
        // but... JSON.parse(null) returns null, and typeof null === "object",
        // so we must check for that, too. Thankfully, null is falsey, so this suffices:
        if (result && typeof result === 'object') {
          return result
        }
    }
    catch (e) { }

    return thing
}

export default function (componentList = {}, behaviorsList = {}) {

  document.addEventListener('DOMContentLoaded', () => {
    const components = Array.from(document.querySelectorAll('[data-component]'))
    components.forEach(component => {
      const ComponentClass = componentList[component.dataset.component]

      if (typeof ComponentClass !== 'undefined') {
        let attributes = mapValues(component.dataset, (value) => tryAsJson(value))
        let element = React.createElement(
          ComponentClass,
          merge(attributes, { children: component.innerHTML.trim() }))
          ReactDOM.render(element, component)
        } else {
          console.error(`${component.dataset.component} is undefined`)
        }
      })

      const behaviors = Array.from(document.querySelectorAll('[data-behavior]'))
      behaviors.forEach(behavior => {
        try {
          const BehaviorClass = behaviorsList[behavior.dataset.behavior]
          new BehaviorClass(behavior, window, document)
        } catch (e) {
          console.error(`${behavior.dataset.behavior} is undefined`)
        }
      })

    })
}
