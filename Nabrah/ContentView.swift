//
//  ContentView.swift
//  Nabrah
//
//  Created by Mashael Alghunaim on 11/06/1444 AH.
//

import SwiftUI
import AVFoundation
import Speech

struct ContentView: View {
    @State var pickedTheme = "1"
    @State private var animateAquaColor = false
    @State private var animateSkyColor = false
    @State private var isRecording = false
    @State private var transcription: String = ""
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    
    var body: some View {
        ZStack{
            Color("darkBlue")
                .ignoresSafeArea()
            VStack{
                Text("اختر اللغة المراد عرضها:").foregroundColor(Color.white)
                    .font(.system(size: 20))
                    .padding(.bottom, 700.0)
                    .padding(.leading,160.0)
                
                
            }
            
            Picker(" ", selection: $pickedTheme, content: {
                Text("العربية").tag("1")
                    .foregroundColor(.gray)
                Text("الإنجليزية").tag("2")
                
                
            }).padding(.bottom, 600.0).pickerStyle(.segmented)
                .padding(.horizontal)
            
            Divider()
            
                .frame(height:0.5)
                .background(Color.gray)
                .padding(.bottom, 540.0)
            VStack{
                Spacer()
                Spacer()
                Text("كُلي آذانٌ صاغية")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30))
                    .padding(.top, 280)
                ZStack{
                    Circle()
                        .frame(width: 200, height: 200, alignment: .bottomLeading)
                        .foregroundColor(Color("veryMediumBlue"))
                        .scaleEffect(animateSkyColor ? 1 : 0.8)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(2), value: animateSkyColor)
                    Circle()
                        .frame(width: 120, height: 120, alignment: .bottomLeading)
                        .foregroundColor(Color("mediumblue"))
                        .scaleEffect(animateSkyColor ? 1 : 1.5)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(3), value: animateAquaColor)
                    
                    
                    
                    Image (systemName: "ear")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                }
                .onTapGesture {
                    self.animateSkyColor.toggle()
                    self.animateAquaColor.toggle()
                    AVAudioSession.sharedInstance().requestRecordPermission { granted in
                        if granted {
                            self.isRecording.toggle()
                            
                            if self.isRecording {
                                let request = SFSpeechAudioBufferRecognitionRequest()
                                request.shouldReportPartialResults = true
                                
                                let node = audioEngine.inputNode
                                let recordingFormat = node.outputFormat(forBus: 0)
                                node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                                    request.append(buffer)
                                }
                                
                                audioEngine.prepare()
                                do {
                                    try audioEngine.start()
                                } catch {
                                    print(error)
                                    return
                                }
                                
                                _ = speechRecognizer?.recognitionTask(with: request) { result, error in
                                    if let result = result {
                                        self.transcription = result.bestTranscription.formattedString
                                    }
                                    else {
                                        if error != nil || result?.isFinal == true {
                                            self.audioEngine.stop()
                                            node.removeTap(onBus: 0)
                                            self.isRecording = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
