#= require jquery
#= require_tree .

$ ->
  console.log "it works 8^P"

  dateFormat = d3.time.format("%x")

  margin =
    left: 80
    right: 20
    top: 80
    bottom: 20

  svgWidth = 100000
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
    label: d.Event
    weight: d.Weight

  resetYearForAxis = (oldDate) ->
    newDate = new Date(oldDate)
    newDate.setFullYear(2001)
    newDate

  csvCallback = (error, data) ->
    console.log data
    [minYear, maxYear] = d3.extent(data, (d) -> d.date.getFullYear())
    x.domain(d3.extent(data, (d) -> resetYearForAxis(d.date)))
    y.domain([minYear, maxYear])
    chart.selectAll(".dot").data(data).enter().append("circle").attr(
      class: "dot"
      r:  (d) -> dotScale(d.weight)
      cx: (d) -> x(resetYearForAxis(d.date))
      cy: (d) -> y(d.date.getFullYear())
    )
    chart.selectAll(".dot-label").data(data).enter().append("text").text((d) -> d.label).attr(
      class: "dot-label"
      x: (d) -> x(resetYearForAxis(d.date))
      y: (d) -> y(d.date.getFullYear())
      "text-anchor": "end"
      dx: -20
      dy: -20
    )

    years = _.range(minYear, maxYear+1)
    chart.selectAll(".year").data(years).enter().append("line").attr(
      class: "year"
      x1: 0
      x2: width
      y1: y
      y2: y
    )

    chart.selectAll(".year-label")
    .data(years)
    .enter()
    .append("text")
    .text((d) -> d)
    .attr(
      class: "year-label"
      "text-anchor": "end"
      x: -10
      y: y
      dy: "0.3em"
    )

  d3.csv "/clojure-timeline.csv", csvAccessor, csvCallback
