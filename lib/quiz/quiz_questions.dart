import 'package:quiz_game/quiz/models/models.dart';

List<Question> quizQuestions = [
  Question(
    question: 'Who scored the fastest penta-trick (9 minutes)?',
    answers: [
      Answer(1, 'Lionel Messi'),
      Answer(2, 'Radamel Falcao'),
      Answer(3, 'Robert Lewandowski'),
      Answer(4, 'Luis Adriano'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Longest scoring streak in England (11 games)?',
    answers: [
      Answer(1, 'Sergio Aguero'),
      Answer(2, 'Luis Suarez'),
      Answer(3, 'Jamie Vardy'),
      Answer(4, 'Zlatan Ibrahimovic'),
      Answer(5, 'Wayne Rooney'),
    ],
    answer: 3,
  ),
  Question(
    type: QuestionType.image,
    question: "Who hasn't received the Ballon d'Or?",
    answers: [
      Answer(1, 'ballon/1.jpg'),
      Answer(2, 'ballon/2.jpg'),
      Answer(3, 'ballon/3.jpg'),
      Answer(4, 'ballon/4.jpg'),
    ],
    answer: 2,
  ),
  Question(
    question:
        'The player who has changed the most clubs in his career (46 clubs)?',
    answers: [
      Answer(1, 'Tulio Costa'),
      Answer(2, 'John Burridge'),
      Answer(3, 'Mario Jardel'),
      Answer(4, 'Sebastian Abreu'),
    ],
    answer: 1,
  ),
  Question(
    type: QuestionType.image,
    question: 'Which one is Adebayo Akinfenwa?',
    answers: [
      Answer(1, 'adebayo/1.jpg'),
      Answer(2, 'adebayo/2.jpg'),
      Answer(3, 'adebayo/3.jpg'),
      Answer(4, 'adebayo/4.jpg'),
    ],
    answer: 3,
  ),
  Question(
    question: 'What confederation does the Jamaica team play in?',
    answers: [
      Answer(1, 'CAF'),
      Answer(2, 'CONCACAF'),
      Answer(3, 'CONMEBOL'),
      Answer(4, 'AFC'),
      Answer(5, 'UEFA'),
    ],
    answer: 2,
  ),
  Question(
    question: 'Which player received the first green card in football history?',
    answers: [
      Answer(1, 'Benedetti Simone'),
      Answer(2, 'Tremolada Luca'),
      Answer(3, 'Aniello Cutolo'),
      Answer(4, 'Galano Christiano'),
    ],
    answer: 4,
  ),
  Question(
    question: 'Who scored the goal that was called the "Hand of God"?',
    answers: [
      Answer(1, 'Pele'),
      Answer(2, 'Diego Maradona'),
      Answer(3, 'Johan Cruyff'),
      Answer(4, 'Romario'),
    ],
    answer: 2,
  ),
  Question(
    type: QuestionType.image,
    question: 'Official ball of the 1990 World Cup in France - Tricolore',
    answers: [
      Answer(1, 'tricolore/1.jpg'),
      Answer(2, 'tricolore/2.jpg'),
      Answer(3, 'tricolore/3.jpg'),
      Answer(4, 'tricolore/4.jpg'),
    ],
    answer: 2,
  ),
  Question(
    question: "Iran's top scorer?",
    answers: [
      Answer(1, 'Ruzbe Cheshmi'),
      Answer(2, 'Alireza Jahanbakhsh'),
      Answer(3, 'Morteza Puraliganji'),
      Answer(4, 'Ali Daei'),
      Answer(5, 'Waheed Amiri'),
    ],
    answer: 4,
  ),
  Question(
    question: 'Which of these players is the defender?',
    answers: [
      Answer(1, 'Jan Vennegoor of Hesselink'),
      Answer(2, 'Sokratis Papastathopoulos'),
      Answer(3, 'Reza Guchannejad'),
      Answer(4, 'Ricky van Wolfswinkel'),
      Answer(5, 'Alex Oxlade-Chamberlain'),
    ],
    answer: 2,
  ),
  Question(
    question:
        'Which team played the selection for the 2002 World Cup in tank tops?',
    answers: [
      Answer(1, 'Algeria'),
      Answer(2, 'Cameroon'),
      Answer(3, 'Ghana'),
      Answer(4, 'Ivory Coast'),
    ],
    answer: 2,
  ),
  Question(
    question: 'Which country team was able to defend the world title?',
    answers: [
      Answer(1, 'Spain'),
      Answer(2, 'Italy'),
      Answer(3, 'Germany'),
      Answer(4, 'France'),
      Answer(5, 'Ukraine'),
    ],
    answer: 2,
  ),
  Question(
    question: 'Which Italian team is called the Bianconeri?',
    answers: [
      Answer(1, 'Inter'),
      Answer(2, 'Milan'),
      Answer(3, 'Roma'),
      Answer(4, 'Juventus'),
    ],
    answer: 4,
  ),
  Question(
    question: 'Which team has never won the Champions League?',
    answers: [
      Answer(1, 'Aston Villa'),
      Answer(2, 'Valencia'),
      Answer(3, 'PSV'),
      Answer(4, 'Celtic'),
      Answer(5, 'Borussia Dortmund'),
    ],
    answer: 2,
  ),
  Question(
    type: QuestionType.image,
    question: 'Emblem of Valladolid',
    answers: [
      Answer(1, 'valladolid/1.gif'),
      Answer(2, 'valladolid/2.gif'),
      Answer(3, 'valladolid/3.gif'),
      Answer(4, 'valladolid/4.gif'),
      Answer(5, 'valladolid/5.gif'),
    ],
    answer: 3,
  ),
  Question(
    type: QuestionType.image,
    question: 'Which one is Paul Pogba?',
    answers: [
      Answer(1, 'pogba/1.png'),
      Answer(2, 'pogba/2.png'),
      Answer(3, 'pogba/3.png'),
      Answer(4, 'pogba/4.png'),
      Answer(5, 'pogba/5.png'),
    ],
    answer: 4,
  ),
  Question(
    question: 'Winner of the 1960 European Championship?',
    answers: [
      Answer(1, 'USSR'),
      Answer(2, 'Yugoslavia'),
      Answer(3, 'Czechoslovakia'),
      Answer(4, 'France'),
    ],
    answer: 1,
  ),
  Question(
    type: QuestionType.image,
    question: 'Which of them is Vasily Berezutsky?',
    answers: [
      Answer(1, 'berezutsky/1.png'),
      Answer(2, 'berezutsky/2.png'),
    ],
    answer: 1,
  ),
  Question(
    type: QuestionType.image,
    question: 'Which one is Kylian Azar?',
    answers: [
      Answer(1, 'azar/1.png'),
      Answer(2, 'azar/2.png'),
      Answer(3, 'azar/3.png'),
    ],
    answer: 2,
  ),
  Question(
    question: 'The only player to score a hat-trick in a World Cup final?',
    answers: [
      Answer(1, 'Alfredo Di Stefano'),
      Answer(2, 'Geoffrey Hurst'),
      Answer(3, 'Ferenc Puskas'),
      Answer(4, 'Miroslav Klose'),
    ],
    answer: 2,
  ),
  Question(
    question: 'The Brazilian who has played in three World Cup finals?',
    answers: [
      Answer(1, 'Pele'),
      Answer(2, 'Kafu'),
      Answer(3, 'Rivaldo'),
      Answer(4, 'Kaka'),
    ],
    answer: 2,
  ),
  Question(
    type: QuestionType.image,
    question: 'Whose fans proudly call themselves Scousers?',
    answers: [
      Answer(1, 'scousers/1.gif'),
      Answer(2, 'scousers/2.gif'),
      Answer(3, 'scousers/3.gif'),
      Answer(4, 'scousers/4.gif'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Which of these national football teams does not exist?',
    answers: [
      Answer(1, 'Macedonia'),
      Answer(2, 'Great Britain'),
      Answer(3, 'Albania'),
      Answer(4, 'San Marino'),
      Answer(5, 'Russia'),
    ],
    answer: 2,
  ),
  Question(
    type: QuestionType.image,
    question: 'Which one is Xavi?',
    answers: [
      Answer(1, 'xavi/1.png'),
      Answer(2, 'xavi/2.jpg'),
      Answer(3, 'xavi/3.jpg'),
      Answer(4, 'xavi/4.jpg'),
    ],
    answer: 3,
  ),
  Question(
    question:
        'Who was the first player to receive the golden ball three times in a row?',
    answers: [
      Answer(1, 'Lionel Messiah'),
      Answer(2, 'Marco Van Basten'),
      Answer(3, 'Michel Platini'),
      Answer(4, 'Cristiano Ronaldo'),
      Answer(5, 'Johan Cruyff'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Who won the Champions League 2009/2010?',
    answers: [
      Answer(1, 'Inter'),
      Answer(2, 'Chelsea'),
      Answer(3, 'Bavaria'),
      Answer(4, 'Barcelona'),
    ],
    answer: 1,
  ),
  Question(
    question: 'Which Country won the most FIFA World Cups?',
    answers: [
      Answer(1, 'Germany'),
      Answer(2, 'Argentina'),
      Answer(3, 'Brazil'),
      Answer(4, 'France'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Which Country won the first FIFA World Cup?',
    answers: [
      Answer(1, 'Argentina'),
      Answer(2, 'Uruguay'),
      Answer(3, 'Italy'),
      Answer(4, 'Brazil'),
    ],
    answer: 2,
  ),
  Question(
    question: 'Who is known as the Flying Sikh?',
    answers: [
      Answer(1, 'Michael Johnson'),
      Answer(2, 'Usain Bolt'),
      Answer(3, 'Milkha Sing'),
      Answer(4, 'Carl Lewis'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Who is known as “The Baltimore Bullet”?',
    answers: [
      Answer(1, 'Roger Federer'),
      Answer(2, 'Usain Bolt'),
      Answer(3, 'Michael Phelps'),
      Answer(4, 'Michael Jordan'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Where is Magnus Carlsen from?',
    answers: [
      Answer(1, 'England'),
      Answer(2, 'UK'),
      Answer(3, 'Norway'),
      Answer(4, 'Germany'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Where did Snooker Game Originate from?',
    answers: [
      Answer(1, 'Austria'),
      Answer(2, 'England'),
      Answer(3, 'India'),
      Answer(4, 'Wales'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Which was the first Sport played on the Moon?',
    answers: [
      Answer(1, 'Golf'),
      Answer(2, 'Tennis'),
      Answer(3, 'Badminton'),
      Answer(4, 'Archery'),
    ],
    answer: 1,
  ),
  Question(
    question: 'Where was the first Commonwealth Games held?',
    answers: [
      Answer(1, 'Canada'),
      Answer(2, 'USA'),
      Answer(3, 'Mexico'),
      Answer(4, 'Chile'),
    ],
    answer: 1,
  ),
  Question(
    question: 'Which Sport has the Term “Butterfly Stroke”?',
    answers: [
      Answer(1, 'Table Tennis'),
      Answer(2, 'Boating'),
      Answer(3, 'Swiming'),
      Answer(4, 'MotoGP'),
    ],
    answer: 3,
  ),
  Question(
    question: 'When did Michael Jordan retire?',
    answers: [
      Answer(1, '2004'),
      Answer(2, '2003'),
      Answer(3, '2005'),
      Answer(4, '2013'),
    ],
    answer: 2,
  ),
  Question(
    question: 'What is the 100m World Record of Usain Bolt?',
    answers: [
      Answer(1, '14.35 Sec'),
      Answer(2, '9.58 Sec'),
      Answer(3, '9.05 Sec'),
      Answer(4, '10.12 Sec'),
    ],
    answer: 2,
  ),
  Question(
    question: 'Which Country has Won the Most World Snooker Championships?',
    answers: [
      Answer(1, 'Wales'),
      Answer(2, 'Scotland'),
      Answer(3, 'England'),
      Answer(4, 'Australia'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Which is the Largest Football Stadium in the World?',
    answers: [
      Answer(1, 'Salt Lake Stadium'),
      Answer(2, 'Rungrado 1st of May Stadium'),
      Answer(3, 'AT&T Stadium'),
      Answer(4, 'Melbourne Cricket Ground'),
    ],
    answer: 2,
  ),
  Question(
    question: 'What are the National Sports of China?',
    answers: [
      Answer(1, 'Table Tennis'),
      Answer(2, 'Baseball'),
      Answer(3, 'Cricket'),
      Answer(4, 'Swimming'),
    ],
    answer: 1,
  ),
  Question(
    question: 'What is the National Game of the USA?',
    answers: [
      Answer(1, 'Tennis'),
      Answer(2, 'Soccer'),
      Answer(3, 'Baseball'),
      Answer(4, 'Basket Ball'),
    ],
    answer: 3,
  ),
  Question(
    question: 'Who is given the Nickname “God of Cricket”?',
    answers: [
      Answer(1, 'Ricky Ponting'),
      Answer(2, 'MS Dhoni'),
      Answer(3, 'Sachin Tendulkar'),
      Answer(4, 'Anil Kumble'),
    ],
    answer: 3,
  ),
  Question(
    question:
        'Who won the Most Grand Prix Motorcycle Racing World Championship?',
    answers: [
      Answer(1, 'Giacomo Agostini'),
      Answer(2, 'Ángel Nieto'),
      Answer(3, 'Mike Hailwood'),
      Answer(4, 'Carlo Ubbiali'),
    ],
    answer: 1,
  ),
  Question(
    question: 'What is the National Game of India?',
    answers: [
      Answer(1, 'Kabaddi'),
      Answer(2, 'Hockey'),
      Answer(3, 'Cricket'),
      Answer(4, 'Football'),
    ],
    answer: 2,
  ),
  Question(
    question: 'Who is the Only Person to Win 6 Olympic Gold Medals in Archery?',
    answers: [
      Answer(1, 'Justin Huish'),
      Answer(2, 'Hubert Van Innis'),
      Answer(3, ' Kim Soo-Nyung'),
      Answer(4, 'Park Kyung-mo'),
    ],
    answer: 2,
  ),
  Question(
    question: 'What is the National Game of Japan?',
    answers: [
      Answer(1, 'Boat Racing'),
      Answer(2, 'Wrestling'),
      Answer(3, 'Sipa'),
      Answer(4, 'Sumo'),
    ],
    answer: 4,
  ),
];
