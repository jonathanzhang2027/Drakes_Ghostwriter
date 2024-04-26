//STILL A WORK IN PROGRESS

//JONATHAN ZHANG
import SwiftUI

struct ContentView: View {
    @State private var artist: String = ""
    @State private var playbackSpeed: Double = 1.0
    @State private var lyricLength: Int = 100
    @State private var generatedLyrics: String = "Lyrics will appear here..."
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Settings")) {
                    TextField("Artist", text: $artist)
                    Stepper("Lyric Length: \(lyricLength) words", value: $lyricLength, in: 50...500)
                    Slider(value: $playbackSpeed, in: 0.5...2.0, step: 0.1) {
                        Text("Playback Speed")
                    }
                    HStack {
                        Text("Speed: \(playbackSpeed, specifier: "%.1f")x")
                        Spacer()
                    }
                }
                
                Section(header: Text("Generate")) {
                    Button("Generate Lyrics") {
                        generateLyrics()
                    }
                }
                
                Section(header: Text("Lyrics")) {
                    Text(generatedLyrics)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationTitle("Drake’s Ghostwriter")
        }
    }
    
    func generateLyrics() {
        // Call your API here
        // For demonstration, let's simulate a network request
        self.generatedLyrics = "Simulating generated lyrics for \(artist) with \(lyricLength) words at \(playbackSpeed)x speed..."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

func generateLyrics() {
    guard let url = URL(string: "https://yourapi.com/generate") else { return }
    
    let requestBody = [
        "artist": artist,
        "speed": playbackSpeed,
        "length": lyricLength
    ]
    
    let request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data, let lyrics = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.generatedLyrics = lyrics
            }
        }
    }.resume()
}
}
