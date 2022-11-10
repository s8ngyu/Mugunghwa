//
//  CreditsView.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 08/11/2022.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationView {
            List {
                if #available(iOS 15.0, *) {
                    Section(header: Text("Soongyu Kwon (Developer)")) {
                        HStack {
                            Text("Twitter")
                            Spacer()
                            Link(destination: URL(string: "https://twitter.com/soongyu_kwon")!) {
                                HStack {
                                    Text("@soongyu_kwon")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                        HStack {
                            Text("Instagram")
                            Spacer()
                            Link(destination: URL(string: "https://instagram.com/s8ngyu.kwon")!) {
                                HStack {
                                    Text("@s8ngyu.kwon")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                        HStack {
                            Text("PayPal")
                            Spacer()
                            Link(destination: URL(string: "https://paypal.me/peterdev")!) {
                                HStack {
                                    Text("buy me a coffee")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                    }.headerProminence(.increased)
                } else {
                    Section(header: Text("Soongyu Kwon (Developer)")) {
                        HStack {
                            Text("Twitter")
                            Spacer()
                            Link(destination: URL(string: "https://twitter.com/soongyu_kwon")!) {
                                HStack {
                                    Text("@soongyu_kwon")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                        HStack {
                            Text("Instagram")
                            Spacer()
                            Link(destination: URL(string: "https://instagram.com/s8ngyu.kwon")!) {
                                HStack {
                                    Text("@s8ngyu.kwon")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                        HStack {
                            Text("PayPal")
                            Spacer()
                            Link(destination: URL(string: "https://paypal.me/peterdev")!) {
                                HStack {
                                    Text("buy me a coffee")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                    }
                }
                
                if #available(iOS 15.0, *) {
                    Section(header: Text("Daan (Icon Designer)")) {
                        HStack {
                            Text("Twitter")
                            Spacer()
                            Link(destination: URL(string: "https://twitter.com/DaanDH13")!) {
                                HStack {
                                    Text("@DaanDH13")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                    }.headerProminence(.increased)
                } else {
                    Section(header: Text("Daan (Icon Designer)")) {
                        HStack {
                            Text("Twitter")
                            Spacer()
                            Link(destination: URL(string: "https://twitter.com/DaanDH13")!) {
                                HStack {
                                    Text("@DaanDH13")
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "arrow.up.right.square")
                                }
                            }
                        }
                    }
                }
                
                
                NavigationLink(destination: LegalNoticesView()) {
                    Text("Legal Notices")
                }
            }.listStyle(.insetGrouped)
            .navigationTitle("Credits")
        }
    }
}

struct LegalNoticesView: View {
    var body: some View {
        List {
            Section(footer: Text("Soongyu Kwon (Mugunghwa)\nCopyright (c) 2022, Soongyu Kwon, All rights reserved.\nLicensed under the GNU GENERAL PUBLIC LICENSE Version 3\n\nCredits:\n@DaanDH13: App Icon\n@opa334dev: TSUtil\nJoey: Aphrodite\n@iOS_App_Dev: Modified Aphrodite\n\n\n\n\nLars Fröder (TSUtil)\nCopyright (c) 2022, Lars Fröder, All rights reserved.\nLicensed under the MIT License\n\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n\n\n\nJoey (Aphrodite)\nCopyright (c) 2020, Joey, All rights reserved.\nLicensed under the BSD 3-Clause License\n\n\nRedistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:\n\n1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.\n\n2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.\n\n3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.\n\nTHIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.")) {
            }
        }.listStyle(.insetGrouped)
        .navigationTitle("Legal Notices")
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
