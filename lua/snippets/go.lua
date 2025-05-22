local ls = require("luasnip")

ls.add_snippets("go", {
  ls.parser.parse_snippet("ginroute", [[
router.GET("$1", func(c *gin.Context) {
  c.JSON(${2:200}, gin.H{
    ${3:"message": "success"}
  })
})]]),
  
  ls.parser.parse_snippet("ginput", [[
var input struct {
  ${1:Field} ${2:string} `json:"${3:field}"`
}
if err := c.ShouldBindJSON(&input); err != nil {
  c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
  return
}]])
})
