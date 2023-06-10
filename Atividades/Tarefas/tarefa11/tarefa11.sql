-- Questão 6
db.Serie.find({"atores.3.personagem":"Hank Schrader"});
db.Serie.find({}, {_id:0,nome:1});
db.Serie.find({"criticas.usuario":"H31TOR"});
db.Serie.find({"produtores.1": "Miles Millar"});

-- Questão 7
db.Serie.find({}, {_id:0, nome:1, produtores:1})
db.Serie.find({pais: "EUA", "notageral":{$gt:4}});
db.Serie.find({pais: "EUA", "notageral":{$gt:4}}).sort({nome:-1});

-- Questão 8
db.Serie.aggregate([{$lookup: {from: "noticia", localField: "titulo", foreignField:"_id", as:"seriedaNoticia"}}, 
{$match: {$expr: {$regexMatch: {input: "$seriedaNoticia.nome", regex: /Breaking Bed/i}}}}]);