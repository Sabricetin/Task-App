struct ReviewModel: Decodable {
    var rating: Int
    var comment: String
    var date: String
    var reviewerName: String
    var reviewerEmail: String
}
