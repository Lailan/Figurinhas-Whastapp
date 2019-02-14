//
//  Frases.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 14/02/19.
//  Copyright © 2019 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import Foundation

class Frase {
    
    var mensagem:[String] = []
    var categoria:CategoriaFrase
    var imagem:UIImage = UIImage()
    
    init(categoria:CategoriaFrase, imagem:UIImage, mensagem:[String]) {
        self.categoria = categoria
        self.imagem = imagem
        self.mensagem = mensagem
    }
    
}

enum CategoriaFrase {
    case religiosa, amor, crush
}

class Frases {
    let listaFrases:[Frase] = [Frase(categoria: .religiosa, imagem: UIImage(), mensagem: ["Gratidão a Deus, Ele é fiel em tudo que faz. ❤ 🙌", "Antes e depois de qualquer coisa, agradeça! 🙏❤✨", "Gratidão é devolver amor a quem te deu a mão. ❤️" , "Regue-se em oração, e Deus vai te fazer florir de graças. ✨","Que você olhe para o céu e só tenha motivos para agradecer! ❤🙌","Gratidão ao Senhor, que tudo faz, que tudo vê e que tudo entende. ❤🙌","Meu coração grita gratidão por Ti, Senhor. 🙏❤✨", "Gratidão a Deus é a rotina da alma pra se viver em paz. 💙🙏","Gratidão é a base de todos os sentimentos bons.. 💖", "Perca tudo, menos a fé e a gratidão a Deus. 💖💖","Grata eu sou a Ele por tudo em minha vida! 💙🙏","Da vida nada cobro. Só agradeço. Porque vida, é afeto de Deus. ❤️","Há sempre mais a agradecer do que a pedir! ❤🙌","Respira fundo… e só agradece! Deus é maravilhoso há todo momento. 💖💖","Se dê conta do quão abençoado você é. ✨","Minha alma ria, mesmo nos tempos de ventania. Era Deus cuidando dos meus dias. ❤🙌","Vida com Deus não é perfeição. É superação, gratidão! 🙏🙏","A gratidão a Deus nos revela caráter. 💙🙏","E todo dia agradecer pela chance de recomeçar. 🙌🙌","Abençoada por Deus demais pra reclamar. 💖💖","Um coração grato a Deus é o suficiente para se ter. 🙏🙏","É tanta bênção que não ouso reclamar de nada! 🙌🙌","A gente sonha, Deus realiza. 🙏🙏","Obrigada, Deus, por sua proteção! 🙏🙏","O agradecimento mais merecido é o que tem Deus no destinatário. 🙌🙌","Todo dia é dia de agradecer a Deus! 🙌🙌","Não há como perder, não há como não vencer. Eu tenho fé, eu tenho Deus. 🙏🙏","O que Deus faz por nós está além do que podemos ver! Sejamos gratos. 🙌🙌","Deus lhe deu um presente de 86.400 segundos hoje. Você usou um para dizer obrigado? 🙏🙌","Gratidão, meu Deus, por tudo que tenho recebido de Ti e por tudo o que ainda está por vir. 🙌🙌","Agradeço a Deus todos os dias pelo que já tenho!! ❤🙌","Agradeço ao Senhor por me dar esta vida plena de verdade e alegria. 🙏🙏","Eu Te agradeço, meu Deus, pois Tu és minha força e o meu refúgio. 🙌💪🙏","Sempre seja grato a Deus por mais um dia, por acordar e poder fazer tudo novo de novo! 💛🙌","Gratidão por sempre me proteger, me guardar e por me permitir viver… 🙌🙌","E ao findar de cada dia, eu ofereço a Deus a minha gratidão! 🙏🙏","Gratidão Senhor, pelo hoje que começa! 💛🙏💛","Antes de cobrar a Deus a vida que sonha, seja grato a todas as bençãos que já tem! 💙💙","Tenho tanto para Te agradecer que nem sei por onde começar… 🙌🙌","Deus, te agradeço de todo o coração por hoje e sempre! 💖💖","Deus é contigo sempre, seja grato a Ele. 💛🙏","Vontade de colocar um bilhetinho de “muito obrigado” embaixo da porta de Deus. 🙌🙏","Meu Deus, a Ti devo a minha vida e todo o meu amor. Gratidão por sempre! 🙌❤","Minha família é tudo pra mim e por ela te agradeço, meu Deus. 😍🙏","Agradeço a Deus por todas as dádivas que recebo na vida dando o melhor de mim para o mundo. 😍🌎🙌","Viva cada dia como se fosse único, agradecendo a Deus por cada segundo! 🙏🙏","Seja grato todo dia e Deus te abençoará cada vez mais! 🙌✨❤","Agradeça a Deus por tudo e todos, a gratidão é bonita e nunca é demais! 🙌🙌","Meu Deus, agradeço por todas as bênçãos na minha vida! 🙌🙌","A gratidão é a memória do coração e o meu coração é Deus! 😍🙏","Gratidão por todas as vezes que Deus cuidou de mim, acalmou meu coração e minha alma, mesmo sendo tão imperfeita!🙏🙏","Tô vivendo, tô aprendendo, tô crescendo, e a Deus, estou sempre agradecendo! 🙏🙌✨","Obrigado Deus por me abençoar muito mais do que eu mereço! 🙏🙏","Quanto mais a gente agradece a Deus, mais coisas boas acontecem… 🙌✨💓","Não esquece de agradecer a Deus por todas as bênçãos! 🙏💓","Deus, só tenho que agradecer por cada dia e por me fazer maior do que qualquer problema! 💫🙏","Feliz ou triste agradeça a Deus todos os dias.🙏","Hoje eu só agradeço Deus, por cuidar tão bem de mim em todos os dias da minha vida e me fortalecer sempre!❤❤","Obrigado pela fé, pela força, pelos sinais de superação. Obrigado por existir, meu Deus.😊🙏","Eu te agradeço por tudo, meu Deus, principalmente por me guardar e me amar da forma mais linda que existe. ❤❤🙏","Gratidão é a prece mais bonita. Obrigada Deus! ❤🙏","Eu te agradeço, meu Deus, pois na tua palavra encontro a tua força que preciso para continuar caminhado.🙏🙏","Agradecer depois do milagre é gratidão. Agradecer antes é fé.🙏✝️","Entrego, agradeço e confio!🙏🙏","Gratidão é quando a gente abraça a Deus e agradece por todas as benção dadas por ele.🙏🙏","Agradeça pelas bençãos que já estão a caminho!","Não importa a religião, agradecer sempre será a prece mais bonita que existe.🙏","Por ser quem eu sou e por tudo que superei na vida eu te agradeço, meu Deus. ✝️🙏","Meu Deus, eu tenho tanto pra agradecer que nem sei por onde começar!🙏","Ser feliz não é possuir tudo, mas ser grato a Deus por tudo aquilo que possui!🙌🙏","Todos os dias percebo suas bençãos e encontro motivos nelas infinitos motivos para continuar lutando e agradecendo!🙏🙏",
])]
}



