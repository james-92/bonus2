//
//  ContentView.swift
//  bonus2
//
//  Created by James.Lai on 18/11/2024.
//

import SwiftUI

struct Question:Equatable{
    let Q:String
    let Ans:Bool
    let pic:ImageResource
}
let questions = [
    Question(Q: "快門越快進光量越小？", Ans: true,pic:.p1),Question(Q: "光圈值越大光圈越大？", Ans: false,pic:.p2),Question(Q: "ISO越高感光度越高？", Ans: true,pic:.p3),Question(Q: "高ISO會有噪點？", Ans: true,pic:.p4),Question(Q: "最廣泛使用的攝影長寬比是4:5？", Ans: false,pic:.p5),Question(Q: "光圈值越大景深越淺？", Ans: false,pic:.p6),Question(Q: "光圈值小會有背景虛化？", Ans: true,pic:.p7),Question(Q: "像素越高越好嗎？", Ans: false,pic:.p8),Question(Q: "光圈數字越小，代表進光量越多？", Ans: true,pic:.p9),
]
struct ContentView: View {
    @State private var currentQuestion: Question?
    @State private var selectedQuestions: [Question] = []
    @State private var ImgshowTrue:Bool = false
    @State private var ImgshowFalse:Bool = false
    @State private var Score:Int = 0
    @State private var Finish:Bool = false
    var body: some View {
        
        ZStack{
            if let question = currentQuestion {
                Text(question.Q)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250, height: 100)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .offset(x:0,y:-250)
                Image(question.pic)
                    .resizable()
                    .scaledToFit()
                    .frame(width:300,height: 200)
                    .opacity(0.8)
                    .offset(x:0,y:-70)
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 180, height: 80)
                        .foregroundColor(.green)
                        .opacity(0.7)
                        .offset(x:-95,y:250)
                    Text("True")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                        .opacity(0.8)
                        .offset(x:-95,y:250)
                }
                .onTapGesture {
                    if question.Ans == true {
                        ImgshowTrue.toggle()
                        Score+=10
                    }
                    else{
                        ImgshowFalse.toggle()
                    }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 180, height: 80)
                        .foregroundColor(.red)
                        .opacity(0.7)
                        .offset(x:95,y:250)
                    Text("False")
                        .foregroundStyle(.black)
                        .font(.largeTitle)
                        .bold()
                        .opacity(0.8)
                        .offset(x:95,y:250)
                }
                .onTapGesture {
                    if question.Ans == false {
                        ImgshowTrue.toggle()
                        Score+=10
                    }
                    else{
                        ImgshowFalse.toggle()
                    }
                }
                Text("Score : \(Score)/100")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .bold()
                    .offset(x:0,y:370)
            }
            
            if ImgshowTrue {
                ZStack{
                    Color.white
                    Image(.check)
                        .resizable()
                        .scaledToFit()
                        .frame(height:100)
                        .offset(y:100)
                }
                .onTapGesture {
                    ImgshowTrue.toggle()
                    generateNewQuestion()
                }
            }
            
            if ImgshowFalse{
                ZStack{
                    Color.white
                    Image(.cross)
                        .resizable()
                        .scaledToFit()
                        .frame(height:100)
                        .offset(y:100)
                }
                .onTapGesture {
                    ImgshowFalse.toggle()
                    generateNewQuestion()
                }
            }
            
            if Finish{
                ZStack{
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    Image(.gameover)
                        .resizable()
                        .scaledToFit()
                        .frame(width:350)
                        .offset(y:-200)
                    Text("Score : \(Score)/100")
                        .foregroundStyle((Score>=80) ? .green : (Score >= 50 ? .yellow : .red))
                        .font(.largeTitle)
                        .bold()
                        .opacity(0.8)
                        .offset(y:-80)
                    Text("Tab To Restart")
                    
                }
                .onTapGesture {
                    Finish.toggle()
                    Score=0
                }
            }
            
        }
        
        .onAppear {
            generateNewQuestion()
        }
    }
    private func generateNewQuestion() {
        
            var newQuestion: Question?
            guard selectedQuestions.count < questions.count else {
                Finish.toggle()
                selectedQuestions.removeAll()
                newQuestion = questions.randomElement()
                if let question = newQuestion {
                    currentQuestion = question
                    selectedQuestions.append(question)
                }
                return
            }
            
            repeat {
                newQuestion = questions.randomElement()
            } while newQuestion == currentQuestion || (newQuestion != nil && selectedQuestions.contains(newQuestion!))
            
            if let question = newQuestion {
                currentQuestion = question
                selectedQuestions.append(question)
            }
        }
}
#Preview {
    ContentView()
}
