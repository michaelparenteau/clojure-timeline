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

  svgWidth = 5000
  svgHeight = 500
  width = svgWidth - margin.left - margin.right
  height = svgHeight - margin.top - margin.bottom

  x = d3.time.scale().range([0,width])
  xAxis = d3.svg.axis().scale(x).orient("bottom")

  dotScale = d3.scale.ordinal().domain(["", "Medium", "High"]).range([5, 10, 20])

  svg = d3.select(".chart").append("svg")
  svg.attr("width", svgWidth)
  svg.attr("height", svgHeight)
  chart = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  csvAccessor = (d) ->
    date: dateFormat.parse d.Date
    event: d.Event
    weight: d.Weight

  csvCallback = (error, data) ->
    console.log data
    x.domain(d3.extent(data, (d) -> d.date))
    chart.append("g").attr("class", "x axis").call(xAxis)
    chart.selectAll(".dot").data(data).enter().append("circle").attr(
      class: "dot"
      r: (d) -> dotScale(d.weight)
      cx: (d) -> x(d.date)
      cy: 0
    )

  d3.csv "/clojure-timeline.csv", csvAccessor, csvCallback
