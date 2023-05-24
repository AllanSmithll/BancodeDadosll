# Opera��es CRUD b�sicas
# -----------------------------------------------------------------


# Inserir um documento na minhanovacole��o e criar a cole��o
db.minhanovacole��o.insertOne({nome: "Jo�o"})

#inserir mais um �nico documento na mesma cole��o 
db.minhanovacole��o.insertOne( 
  { nome: "Marcia", idade: 23, hobbies: ["dan�a", "filmes"], 
    endere�o: { rua: "JJ", num: 35, apto: 202 } } )
    
#verificando inser��o
    
db.minhanovacole��o.find( { nome: "Marcia" } )
    
#inserindo a partir de uma variavel
document = ( { nome: "An�sio", idade: 36, hobbies: ["futebol", "rock"], endere�o: { rua: "MM", num: 305, apto: 502 } } )
db.minhanovacole��o.insert(document)

#consultar a cole��o

db.minhanovacole��o.find( { nome: "Marcia" } )

# inserir v�rios documentos em uma cole��o
db.minhanovacole��o.insertMany( [ 
  { nome: "Alana", idade: 33, hobbies: ["volley", "filmes"], 
           endere�o: { rua: "XX", num: 305, apto: 502 } }, 
  { nome: "Alvaro", idade: 43, hobbies: ["volley", "squash"], 
           endere�o: { rua: "YY", num: 43 } }]  )
           
db.minhanovacolec�o.insertMany( [ 
  { nome: "Allan", idade:18, hobbies: ["futsal","animes"],
            endere�o: {rua: "Tal", num: 04, apto: 100 } },
  { nome: "Marcio", idade:20, hobbies: ["futsal","academia"],
            endere�o: {rua: "Acol�", num: 2029, apto: 200 } }] )

# criando cole��o quando se cria �ndice ou se insere documento 
db.NovaCole��oTeste.insertOne({x: 1})
db.NovaCole��oTeste3.createIndex({y: 1})

# contando documentos na cole��o
db.minhanovacole��o.count();

# Recuperando documentos com o FIND
db.minhanovacole��o.find( {nome : "Marcia"})

#filtros
db.minhanovacole��o.find( { nome: "Jo�o" } )
db.minhanovacole��o.find( { nome: { $in: [ "Jo�o", "Marcia" ] } } )
db.minhanovacole��o.find( { nome: /^A/ } )

db.minhanovacole��o.find({ 
$or : 
    [ {"nome" : "Alvara"}, 
      {"nome" : "Alvaro"} ] }) 

db.minhanovacole��o.find(
{ "nome" : 
{ $in : ["Alvara", "Alvaro"] } }) 

# find com proje��o
db.minhanovacole��o.find( { nome: { $in: [ "Jo�o", "Marcia" ] } }, { nome: 1, idade: 1 } )
db.minhanovacole��o.find( { nome: { $in: [ "Jo�o", "Marcia" ] } }, { nome: 1, idade: 1, _id: 0  } )

#acesso a documentos embutidos
db.minhanovacole��o.find( { endere�o: { rua: "JJ", num: 35, apto: 202 } } )
db.minhanovacole��o.find( { "endere�o.rua": "JJ" } )

# acesso a arrays
db.minhanovacole��o.find( { "hobbies.1": "filmes" } )
db.minhanovacole��o.find( { hobbies: ["volley", "filmes"] } )
db.minhanovacole��o.find( { hobbies: { $all: ["filmes", "volley"] } } )

# outras consultas

db.minhanovacole��o.find( { nome: "Alvaro" }, { idade: 0, _id: 0 } )

db.minhanovacole��o.find( { nome: "Alvaro" }, { idade: 1, "endere�o.rua": 1 } )

# atualizando dados
db.minhanovacole��o.updateOne( { "nome" : "Alvaro" }, { $set: { "idade" : 43 } })

db.minhanovacole��o.updateMany( { idade: { $gt: 40 } }, { $set: { "B�nus" : true } } )

db.minhanovacole��o.update( { "nome" : "Alvara" }, { $set: {"idade" : 57, hobbies: ["judo", "filmes"], 
   endere�o: { rua: "KK", num: 305, apto: 202 } } }, 
   { upsert: true })

# removendo objeto
db.minhanovacole��o.deleteOne( { B�nus: true } )
