#= require jquery
#= require_tree .

$ ->
  console.log "it works 8^P"

  dateFormat = d3.time.format("%x")

  margin =
    left: 20
    right: 20
    top: 20
    bottom: 20

  svgWidth = 1000
  svgHeight = 1000
  width = svgWidth - margin.left - margin.right
  height = svgHeight - margin.top - margin.bottom

  x = d3.time.scale().range([0,width])

  y = d3.scale.linear().range([0, height])

  dotScale = d3.scale.ordinal().domain(["", "Medium", "High"]).range([5, 10, 20])

  svg = d3.select(".chart").append("svg")
  svg.attr("width", svgWidth)
  svg.attr("height", svgHeight)
  chart = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  csvAccessor = (d) ->
    date: dateFormat.parse d.Date
    event: d.Event
    weight: d.Weight

  resetYearForAxis = (oldDate) ->
    newDate = new Date(oldDate)
    newDate.setFullYear(2001)
    newDate

  csvCallback = (error, data) ->
    console.log data
    x.domain(d3.extent(data, (d) -> resetYearForAxis(d.date)))
    y.domain(d3.extent(data, (d) -> d.date.getFullYear()))
    chart.selectAll(".dot").data(data).enter().append("circle").attr(
      class: "dot"
      r:  (d) -> dotScale(d.weight)
      cx: (d) -> x(resetYearForAxis(d.date))
      cy: (d) -> y(d.date.getFullYear())
    )
    chart.selectAll(".year").data(data).enter().append("line").attr(
      class: "year"
      x1: 0
      x2: width
      y1: (d) -> y(d.date.getFullYear())
      y2: (d) -> y(d.date.getFullYear())
    )

  d3.csv "/clojure-timeline.csv", csvAccessor, csvCallback
