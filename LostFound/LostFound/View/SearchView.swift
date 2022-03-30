//
//  SearchView.swift
//  LostFound
//
//  Created by 90305906 on 3/27/22.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @Binding var showResults: Bool
    @Binding var loadSearch: Bool
    
    var body: some View {
        
        
        HStack {
            HStack (spacing: 0) {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(.leading, 24)
                }
                .frame(height: 4)
                .padding()
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.leading)
                .onTapGesture(perform: {
                    isSearching = true
                    showResults = true
                })
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.horizontal, 32)
                        Spacer()
                        Button(action: {searchText = ""}, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding([.vertical, .trailing])
                                .foregroundColor(.gray)
                                .opacity(isSearching ? 1 : 0)
                        })
                    }
                        .foregroundColor(.gray)
                )
                .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                //isFocused = false
                                print("done")
                            }
                        }
                    }
                
                
                if isSearching {
                    Button(action: {
                        isSearching = false
                        searchText = ""
                        showResults = false
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("Cancel")
                            .padding(.horizontal, 8)
                    }).transition(.move(edge: .trailing))
                    
                }
            }
            
            //Spacer()
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .frame(width: 20.0, height: 20.0)
            }
            .padding([.top, .bottom, .trailing])
            
            
            //Spacer()
            //Spacer()
        }.padding(.top, 8)
            .padding(.bottom, 2)
        
        
    }
    
    
}
