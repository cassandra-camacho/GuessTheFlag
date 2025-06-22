#  <#Title#>

HStack, VStack, and Zstack
You can adjust the spacing of the stack
Ex. VStack(spacing:20)
And the alignment, whether it is centered or not
VStack(alignment: .leading)
leading and trailing - edge left and right
These stacks automatically adjust to the screen
IF you want to change that there is a SPACER 
To push the code 

    var body: some View {
        VStack {
           Text("First")
           Text("Second")
           Text("Third")
            
           Spacer()
        }
        .padding()
    }
}
This moves the code all the way to the stack

ZStack controls the depth of things 
For overlapping things 
It does have an alignment (no spacing though)
Draws its views from back to front, so the first text will put in the back 


Try placing several horizontal stacks inside a single vertical stack – can you make a 3x3 grid?

struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                Text("First")
                Text("Second")
                Text("Third")
            }
            
            HStack{
                Text("First")
                Text("Second")
                Text("Third")
            }
            
                HStack{
                Text("First")
                Text("Second")
                Text("Third")
                }
            
            }
            }
        }

Colors and Frames 
.background(.red) - will apply to the ZStack or whatever stack you have 
Color.red will apply to whole background 
Color is a view 
Color expands to cover all space

Frame modifier 
But you can apply frame to only have it cover a certain area 

    var body: some View {
        ZStack{
            Color.red
                .frame(width:200, height: 200)
            Text("Your Content")
            
        }
    }
}

Color. primary - will be black/match whatever is suitable (will be different in dark or light mode)
Color. secondary - will be lesser 

Can also make your own color
            Color(red: 1, green: 0.8, blue: 0)

Safe Area 
Will leave some white depending on the safe area
Safe area is where all of the text and colors can go 
However, you can input .ignoresSafeArea() to have it occupy all of the screen
Background modifier can accept materials 
glossy effect example 

Materials
Apple calls the ultraThin Material vibrancy 


struct ContentView: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Color.red
                Color.blue
                
            }
            Text("Your content")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}


SwiftUI gives us four kinds of gradients to work with, and like colors most of them are also views that can be drawn in our UI.

Gradients are made up of several components: need to provide it with 3 things

An array of colors to show - the color itself
Size and direction information
The type of gradient to use - Linear, Radial, Angular 


Can also provide gradient stops to express how far you want the color to go /where you want it to stop


        LinearGradient(stops: [
            Gradient.Stop(color: .white, location: 0.45),
            Gradient.Stop(color: .black, location: 0.55)
            ], startPoint: .top, endPoint: .bottom)
    }
}

45 percent of the way it is white and then 55% is black 


Radial gradients move outwards from the center 
struct ContentView: View {
    var body: some View {
        RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
    }
}

AngularGradient cycles around the circle rather than radiating outwards 
        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
        rainbow effect 
        
    All gradients have stops option

Gives it an ever so slight gradient so you can add . gradient to a color 
        Text("Your Content")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.white)
            .background(.red.gradient)
    }
}

Buttons and images 
Don't use too many borderedProminents 


struct ContentView: View {
    var body: some View {
        VStack {
            Button("Button 1") {}
                .buttonStyle(.bordered)
            
            Button("Button 2", role: .destructive) {}
                .buttonStyle(.bordered)
            
            Button("Button 3") {}
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            
            Button("Button 4", role: .destructive) {}
                .buttonStyle(.borderedProminent)
            
        }
    }
    func executeDelete() {
        print("Now deleting..")
    }
}


can add Images

Image(systemName)
this pulls in images from Apple's Catalog


Using label is a great choice 

struct ContentView: View {
    var body: some View {
        Button {
            print("Button was tapped")
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
    func executeDelete() {
        print("Now deleting..")
    }
}


Notifying the users through alerts
Popup window

Views are functions of our apps state - no different for alerts 

Basic swiftUI alert has a title and a button to dismiss it 
The more interesting part is how we present alert
We create some state within our view that tracks whether the alert is showing 


@State private var showingAlert = false 
Want it to be true when you want it to be showing 


struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        Button("Show alert") {
            showingAlert = true
        }
            .alert("Important message", isPresented: $showingAlert) {
                //two way binding for showing alert matters because Button will dismiss the alert, all buttons dismiss the alert
                Button("OK") { }
            }
    }
}


DAY 21
Stacking up buttons 


Showing the player's score with an alert'
Randomize order in which flags are created
Show an alert whether they are right or wrong when the tap a flag
and the show an alert whether they are right or wrong 

    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()

We wnat to show the user an alert saying what happened so they can track their progrress. 
Add this propert to store whether the alert is showing
    @State private var showingScore = false
Add this property to store the title that will be shown inside the alert
    @State private var scoreTitle = ""

Will accept number of button that was tapped compare that against the correctAnswert and then select two new properties to be meaningful for alert 


        .alert(scoreTitle, isPresented: $showingScore) {
        Button(countOfFlagsTapped < 8 ? "Continue" : "Restart", 
       action: countOfFlagsTapped < 8 ? askQuestion : resetGame)
        } message: {
            Text(alertMessage)
        }
    }
