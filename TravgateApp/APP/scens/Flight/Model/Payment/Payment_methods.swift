/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Payment_methods : Codable {
	let code : String?
	let name : String?
	let pg : String?
	let type : String?
	let amount : String?
	let currency_code : String?
	let fee : String?
	let fee_description : String?
	let icon : String?
	let flow : String?
	let redirect_url : String?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case name = "name"
		case pg = "pg"
		case type = "type"
		case amount = "amount"
		case currency_code = "currency_code"
		case fee = "fee"
		case fee_description = "fee_description"
		case icon = "icon"
		case flow = "flow"
		case redirect_url = "redirect_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		pg = try values.decodeIfPresent(String.self, forKey: .pg)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		currency_code = try values.decodeIfPresent(String.self, forKey: .currency_code)
		fee = try values.decodeIfPresent(String.self, forKey: .fee)
		fee_description = try values.decodeIfPresent(String.self, forKey: .fee_description)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		flow = try values.decodeIfPresent(String.self, forKey: .flow)
		redirect_url = try values.decodeIfPresent(String.self, forKey: .redirect_url)
	}

}