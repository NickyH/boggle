User.delete_all
Game.delete_all
Answer.delete_all
Result.delete_all

u1 = User.create(username: 'Nicky', email: 'nickyhughes00@gmail.com', password: 'a', password_confirmation: 'a', high_score: 50)
u2 = User.create(username: 'Danni', email: 'danni@gmail.com', password: 'a', password_confirmation: 'a', high_score: 60)
u3 = User.create(username: 'Lizzy', email: 'lizzy@gmail.com', password: 'a', password_confirmation: 'a', high_score: 20)

g1 = Game.create(name: 'FirstBoggleGame', best_word: 'ration', letters: 'CMDNATIEOSSRENJE')
g2 = Game.create(name: 'MyTurnToWin', best_word: 'style', letters: 'ENRSBSTTLAMYAHWB')
g3 = Game.create(name: 'LetMeWin', best_word: 'posting', letters: 'LEVIIMTSGTOPDNHO')

u1.games = [g1, g2, g3]

r1 = Result.create(score: 15)
r2 = Result.create(score: 21)
r3 = Result.create(score: 12)


g1.result = r1
g2.result = r2
g3.result = r3
