A tech test for Citizens Advice


Test fetch requests

fetch("http://localhost:3000/api/v1/login", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({user: { username: 'Guy', password: '123123'}})
 })
   .then(res => res.json())
   .then(d => console.log(d))


  fetch("http://localhost:3000/api/v1/users", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({user: { username: 'Guy', password: '123123', email: 'hello@example.com'}})
 })
   .then(res => res.json())
   .then(d => console.log(d))
