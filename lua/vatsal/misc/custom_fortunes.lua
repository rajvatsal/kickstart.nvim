math.randomseed(os.time())
local _getFortune = function()
  local _fortunes = {
    ' \nI\'m sick of following my dreams, man. I\'m just going\nto ask where they\'re going and hook up with ’em later.\n \n—Mitch Hedberg',
    ' \nBefore you criticize someone, you should walk a mile in\ntheir shoes. That way when you criticize them, you are a\nmile away from them and you have their shoes. \n \n—Jack Handey',
    'Before you marry a person, you should first make them use a computer with slow Internet to see who they really are. —Will Ferrell',
    ' \nCommon sense is like deodorant. The people who need it\nmost never use it.\n \n—Anonymous',
    ' \nHere’s all you have to know about men and women: Women\nare crazy, men are stupid. And the main reason women\nare crazy is that men are stupid.\n \n—George Carlin',
    ' \nCal: “You are really pushing my buttons today.”\nBecky: “Which one is \'mute \'?”\n \n—Waitress, the Musical',
    ' \nMy grief counselor died. He was so good, I don’t even\ncare.',
    ' \nThe doctor gave me one year to live, so I shot him with\nmy gun. The judge gave me 15 years. Problem solved.',
    ' \nMy grandfather said my generation relies too much on\nthe latest technology. So I unplugged his life support.',
    ' \nFeminism: because not all women can be pretty.',
    ' \nI am busy right now, can I ignore you some other time?',
    ' \nIt’s okay if you don’t like me. Not everyone has\ngood taste.',
    ' \nLight travels faster than sound. This is why some\npeople appear bright until they speak.\n \n-Steven Wright',
    ' \nDon’t worry about what people think. They don’t do it\nvery often.',
    ' \nIf at first, you don’t succeed, skydiving is not for\nyou.',
    ' \nPeople say that laughter is the best medicine… your\nface must be curing the world.',
    ' \nWell at least your mom thinks you’re pretty.',
    ' \nThe stuff you heard about me is a lie. I\'m way\nworse.',
    ' \nMarriage. Because your crappy day doesn\'t have to\nend at work.',
    ' \nI don\'t have a welcome mat at my door because I\'m\nnot a liar.',
    ' \nI\'ll get over it. I just need to be dramatic first.',
    ' \nSorry for being late. I got caught up enjoying my last\nfew minutes of not being here.',
    ' \nYou\'re everything I want in someone I don\'t want\nanymore.',
    ' \nFriendships must be built on a solid foundation of\nalcohol, sarcasm, inappropriateness, and shenanigans.',
  }
  return _fortunes[math.random(1, #_fortunes)]
end