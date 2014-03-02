root = exports ? this
root.convertToRange = (val, fromMin, fromMax, toMin, toMax) ->
  return toMin + ((toMax - toMin) / (fromMax - fromMin)) * (val - fromMin)