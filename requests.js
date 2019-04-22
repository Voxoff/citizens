const jwt = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1N…1Njd9.ROrQgqyDrMTdDsAnAfxzxqfWoSb-Sc4e0attCu5YCNw'
fetch("http://localhost:3000/api/v1/login", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({ user: { username: 'admin', password: '123123' } })
})
  .then(res => res.json())
  .then(data => console.log(data.jwt))


fetch("http://localhost:3000/api/v1/users", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({ user: { username: 'Guy', password: '123123', email: 'hello@example.com' } })
})
  .then(res => res.json())
  .then(d => console.log(d))

fetch("http://localhost:3000/api/v1/users/1", {
  method: "GET",
  headers:
  {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${jwt}`
  }})
  .then(res => res.json())
  .then(d => console.log(d))


  #Admin

fetch("http://localhost:3000/api/v1/login", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({ user: { username: 'admin', password: '123123' } })
})
  .then(res => res.json())
  .then(d => console.log(d))



#Groups

fetch("http://localhost:3000/api/v1/groups", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${jwt}`
  },
  body: JSON.stringify({ group: { name: 'admingroup' } })
})
  .then(res => res.json())
  .then(d => console.log(d))

  #Groups

fetch("http://localhost:3000/api/v1/groups/1/add_users", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${jwt}`
  },
  body: JSON.stringify({ group: { name: 'admin_group', user_ids: ["1", "2"] } })
})
  .then(res => res.json())
  .then(d => console.log(d))


fetch("http://localhost:3000/api/v1/users/profile", {
  method: "POST",
  headers:
  {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${jwt}`
  },
  body: JSON.stringify({ user: { username: 'Guy' } })
})
  .then(res => res.json())
  .then(d => console.log(d))
