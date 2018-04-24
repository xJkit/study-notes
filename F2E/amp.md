# AMP Railshow Taipei 20180424

## Introduction

* Example site:
  * `Special Daily`
  * 風傳媒
  * 飛比價格

* Limitations
  * No custum js.
  * use amp component. (必須給定寬高)
  * No external CSS. All CSS are embedded.

* Layout
  * fixed
  * responsive
  * fill
* Keep HTML5
  * srcsec
  * media query

* components (常用、值得)
  * amp-img
  * amp-youtube, amp-twitter
  * amp-carousel
  * amp-accordion (show more)
  * amp-lightbox (不允許未互動的情況下 show 出來)
  * amp-image-lightbox
  * amp-sidebar
  * amp-timeago
  * amp-video
  * amp-lightbox-gallery = amp-lightbox + amp-carousel
  * amp-fx-flying-carpet (ads)
  * amp-animation (parallax scrolling)
  * amp-position-observer (根據使用者滑動幅度做 animation)

* amp by example
  * www.ampbyexample.com
  * amp interactive playground
  * www.ampstart.com (templates)

## News & Blogs

e-commerce  最需要 AMP!?

* 常用 components
  * amp-selector
  * amp-list
  * amp-state
  * amp-bind
    * State
    * Binding
    * Mutation
    * `JavaScript Lite`
  * amp-bind + amp-mustache + amp-date-picker
  * amp-form

## PWA

* PWA v.s AMP
  * PWA:
    * first load: `slow`
    * second load: `fast` (via chche)
    * amp-serviceworker
  * PWA + APM = **start fast, stay fast**.

"*An investment in AMP today is an investment in your PWA tomorrow*"

* Shadow DOM

## AMP In Production

* validations
  * gulp-amp-validator

* 。。。

## What's next in AMP

  * amp-datepicker
  * infinite scroll
  * lightbox-gallery
  * video docking
  * sticky mute button for amp-video/audio
  * full screen on device orientation
  * customizable video control
  * AMP stories
  * amp-layout (launched)
  * amp toolbox optimizer (npm install)

## Yahoo AMP by Paul

* 常用組件
  * amp-form
  * amp-list
  * amp-mustache (template engine)
  * amp-bind
  * amp-access

## Monetization in AMP

* Ads on AMP today
  * Disruptive ads (破壞 UX)
  * Slow loading ads
  * Unsafe ads
* Making ads work in AMP
  * set dimensions
  * separate the ads
  * prioritized content
