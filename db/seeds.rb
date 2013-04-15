User.delete_all
Game.delete_all
Answer.delete_all
Result.delete_all

u1 = User.create(username: 'Nicky', email: 'nickyhughes00@gmail.com', password: 'a', password_confirmation: 'a', high_score: 50)
u2 = User.create(username: 'Danni', email: 'danni@gmail.com', password: 'a', password_confirmation: 'a', high_score: 60)
u3 = User.create(username: 'Lizzy', email: 'lizzy@gmail.com', password: 'a', password_confirmation: 'a', high_score: 20)

# g1 = Game.create(name: 'FirstBoggleGame', best_word: 'uneven')
# g2 = Game.create(name: 'MyTurnToWin', best_word: 'nonsense')
# g3 = Game.create(name: 'LetMeWin', best_word: 'equation')

# a1 = Answer.create(word: 'hello')
# a2 = Answer.create(word: 'this')
# a3 = Answer.create(word: 'is')
# a4 = Answer.create(word: 'boggle')
# a5 = Answer.create(word: 'game')


# g1.answers = [a1, a2, a3, a4, a5]
