// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> AnyObject
}

public enum ErrorResponse : ErrorType {
    case RawError(Int, NSData?, ErrorType)
    case activityGet403(Error)
    case activityIdGet403(Error)
    case activityIdGet404(Error)
    case activityIdPut403(Error)
    case activityIdPut404(Error)
    case authDelete403(Error)
    case authForgotPasswordEmailAddressPut400(Error)
    case authForgotPasswordEmailAddressPut404(Error)
    case authLoginTypePut403(Error)
    case connectionsUsernameDelete403(Error)
    case connectionsUsernamePut403(Error)
    case connectionsUsernamePut404(Error)
    case contentContentTypeGet404(Error)
    case contentContentTypeLanguageGet404(Error)
    case matchesGet403(Error)
    case matchesUsernameDatesDatePut403(Error)
    case matchesUsernameDatesDatePut404(Error)
    case matchesUsernameDatesGet403(Error)
    case matchesUsernameDatesGet404(Error)
    case matchesUsernameDatesPut403(Error)
    case matchesUsernameDatesPut404(Error)
    case matchesUsernameDelete403(Error)
    case matchesUsernamePut202(Status)
    case matchesUsernamePut403(Error)
    case matchesUsernamePut404(Error)
    case matchmakersGet403(Error)
    case meGet400(Error)
    case meGet403(Error)
    case meImagePost400(Error)
    case meImagePost403(Error)
    case meImagePost413(Error)
    case meIsSingleDelete400(Error)
    case meIsSingleDelete403(Error)
    case meIsSinglePut400(Error)
    case meIsSinglePut403(Error)
    case meMatchWithGenderPut400(Error)
    case meMatchWithGenderPut403(Error)
    case mePasswordPut400(Error)
    case mePasswordPut403(Error)
    case mePut400(Error)
    case mePut403(Error)
    case messagesUsernameGet403(Error)
    case messagesUsernameGet404(Error)
    case messagesUsernameImagePost400(Error)
    case messagesUsernameImagePost403(Error)
    case messagesUsernameImagePost413(Error)
    case messagesUsernamePut403(Error)
    case messagesUsernamePut404(Error)
    case singlesGet403(Error)
    case singlesUsernamePatch400(Error)
    case singlesUsernamePatch403(Error)
    case singlesUsernamePatch404(Error)
    case singlesUsernamePut400(Error)
    case singlesUsernamePut403(Error)
    case singlesUsernamePut404(Error)
    case subscriptionsTypeDelete400(Error)
    case subscriptionsTypeDelete403(Error)
    case subscriptionsTypeDelete404(Error)
    case subscriptionsTypeGet400(Error)
    case subscriptionsTypeGet403(Error)
    case subscriptionsTypeGet404(Error)
    case subscriptionsTypePut400(Error)
    case subscriptionsTypePut403(Error)
    case subscriptionsTypePut404(Error)
    case supportedVersionsVersionGet404(Error)
    case usersGet403(Error)
    case usersPut400(Error)
    case usersPut403(Error)
    case usersUsernameConnectionsPut403(Error)
    case usersUsernameConnectionsPut404(Error)
    case usersUsernameGet404(Error)
    case usersUsernamePotentialMatchesGet403(Error)
    case usersUsernamePotentialMatchesGet404(Error)
}

public class FileUpload {
    public let body: NSData
    public let fileName: String
    public let mimeType: String

    public init(body: NSData, fileName: String, mimeType: String) {
        self.body = body
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

public class Response<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T

    public init(statusCode: Int, header: [String: String], body: T) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: NSHTTPURLResponse, body: T) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = dispatch_once_t()
class Decoders {
    static private var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz clazz: T.Type, decoder: ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as! AnyObject }
    }

    static func decode<T>(clazz clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz clazz: T.Type, source: NSData) throws -> T {
        let json = try NSJSONSerialization.JSONObjectWithData(source, options: NSJSONReadingOptions())
        return Decoders.decode(clazz: clazz, source: json)
    }

    static func decode<T>(clazz clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.intValue as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.longLongValue as! T;
        }
        if T.self is NSUUID.Type && source is String {
            return NSUUID(UUIDString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is NSData.Type && source is String {
            return NSData(base64EncodedString: source as! String, options: NSDataBase64DecodingOptions()) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static private func initialize() {
        dispatch_once(&once) {
            let formatters = [
                "yyyy-MM-dd",
                "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss'Z'",
                "yyyy-MM-dd'T'HH:mm:ss.SSS"
            ].map { (format: String) -> NSDateFormatter in
                let formatter = NSDateFormatter()
                formatter.dateFormat = format
                return formatter
            }
            // Decoder for NSDate
            Decoders.addDecoder(clazz: NSDate.self) { (source: AnyObject) -> NSDate in
               if let sourceString = source as? String {
                    for formatter in formatters {
                        if let date = formatter.dateFromString(sourceString) {
                            return date
                        }
                    }

                }
                if let sourceInt = source as? Int {
                    // treat as a java date
                    return NSDate(timeIntervalSince1970: Double(sourceInt / 1000) )
                }
                fatalError("formatter failed to parse \(source)")
            } 

            // Decoder for [Activity]
            Decoders.addDecoder(clazz: [Activity].self) { (source: AnyObject) -> [Activity] in
                return Decoders.decode(clazz: [Activity].self, source: source)
            }
            // Decoder for Activity
            Decoders.addDecoder(clazz: Activity.self) { (source: AnyObject) -> Activity in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Activity()
                instance.attributes = Decoders.decodeOptional(clazz: ActivityAttributes.self, source: sourceDictionary["attributes"])
                instance.icon = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["icon"])
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                instance.originUser = Decoders.decodeOptional(clazz: BaseUser.self, source: sourceDictionary["origin_user"])
                instance.responseMessage = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["response_message"])
                instance.responses = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["responses"])
                instance.timestamp = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["timestamp"])
                instance.viewedAt = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["viewed_at"])
                return instance
            }


            // Decoder for [ActivityAttributes]
            Decoders.addDecoder(clazz: [ActivityAttributes].self) { (source: AnyObject) -> [ActivityAttributes] in
                return Decoders.decode(clazz: [ActivityAttributes].self, source: source)
            }
            // Decoder for ActivityAttributes
            Decoders.addDecoder(clazz: ActivityAttributes.self) { (source: AnyObject) -> ActivityAttributes in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ActivityAttributes()
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                return instance
            }


            // Decoder for [ActivityResponse]
            Decoders.addDecoder(clazz: [ActivityResponse].self) { (source: AnyObject) -> [ActivityResponse] in
                return Decoders.decode(clazz: [ActivityResponse].self, source: source)
            }
            // Decoder for ActivityResponse
            Decoders.addDecoder(clazz: ActivityResponse.self) { (source: AnyObject) -> ActivityResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ActivityResponse()
                instance.text = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["text"])
                instance.activityResponseType = ActivityResponse.ActivityResponseType(rawValue: (sourceDictionary["activity_response_type"] as? String) ?? "") 
                instance.responseMessage = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["response_message"])
                return instance
            }


            // Decoder for [BaseUser]
            Decoders.addDecoder(clazz: [BaseUser].self) { (source: AnyObject) -> [BaseUser] in
                return Decoders.decode(clazz: [BaseUser].self, source: source)
            }
            // Decoder for BaseUser
            Decoders.addDecoder(clazz: BaseUser.self) { (source: AnyObject) -> BaseUser in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = BaseUser()
                instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"])
                instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"])
                instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"])
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                return instance
            }


            // Decoder for [Content]
            Decoders.addDecoder(clazz: [Content].self) { (source: AnyObject) -> [Content] in
                return Decoders.decode(clazz: [Content].self, source: source)
            }
            // Decoder for Content
            Decoders.addDecoder(clazz: Content.self) { (source: AnyObject) -> Content in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Content()
                instance.content = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["content"])
                return instance
            }


            // Decoder for [Dates]
            Decoders.addDecoder(clazz: [Dates].self) { (source: AnyObject) -> [Dates] in
                return Decoders.decode(clazz: [Dates].self, source: source)
            }
            // Decoder for Dates
            Decoders.addDecoder(clazz: Dates.self) { (source: AnyObject) -> Dates in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Dates()
                instance.dates = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["dates"])
                return instance
            }


            // Decoder for [Education]
            Decoders.addDecoder(clazz: [Education].self) { (source: AnyObject) -> [Education] in
                return Decoders.decode(clazz: [Education].self, source: source)
            }
            // Decoder for Education
            Decoders.addDecoder(clazz: Education.self) { (source: AnyObject) -> Education in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Education()
                instance.degree = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["degree"])
                instance.school = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["school"])
                return instance
            }


            // Decoder for [Employment]
            Decoders.addDecoder(clazz: [Employment].self) { (source: AnyObject) -> [Employment] in
                return Decoders.decode(clazz: [Employment].self, source: source)
            }
            // Decoder for Employment
            Decoders.addDecoder(clazz: Employment.self) { (source: AnyObject) -> Employment in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Employment()
                instance.company = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["company"])
                instance.title = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["title"])
                return instance
            }


            // Decoder for [Empty]
            Decoders.addDecoder(clazz: [Empty].self) { (source: AnyObject) -> [Empty] in
                return Decoders.decode(clazz: [Empty].self, source: source)
            }
            // Decoder for Empty
            Decoders.addDecoder(clazz: Empty.self) { (source: AnyObject) -> Empty in
                let instance = Empty()
                return instance
            }


            // Decoder for [Error]
            Decoders.addDecoder(clazz: [Error].self) { (source: AnyObject) -> [Error] in
                return Decoders.decode(clazz: [Error].self, source: source)
            }
            // Decoder for Error
            Decoders.addDecoder(clazz: Error.self) { (source: AnyObject) -> Error in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Error()
                instance.type = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["type"])
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                return instance
            }


            // Decoder for [Image]
            Decoders.addDecoder(clazz: [Image].self) { (source: AnyObject) -> [Image] in
                return Decoders.decode(clazz: [Image].self, source: source)
            }
            // Decoder for Image
            Decoders.addDecoder(clazz: Image.self) { (source: AnyObject) -> Image in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Image()
                instance.url = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["url"])
                return instance
            }


            // Decoder for [Location]
            Decoders.addDecoder(clazz: [Location].self) { (source: AnyObject) -> [Location] in
                return Decoders.decode(clazz: [Location].self, source: source)
            }
            // Decoder for Location
            Decoders.addDecoder(clazz: Location.self) { (source: AnyObject) -> Location in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Location()
                instance.city = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["city"])
                instance.state = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["state"])
                instance.country = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["country"])
                return instance
            }


            // Decoder for [LoginForm]
            Decoders.addDecoder(clazz: [LoginForm].self) { (source: AnyObject) -> [LoginForm] in
                return Decoders.decode(clazz: [LoginForm].self, source: source)
            }
            // Decoder for LoginForm
            Decoders.addDecoder(clazz: LoginForm.self) { (source: AnyObject) -> LoginForm in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = LoginForm()
                instance.facebook = Decoders.decodeOptional(clazz: LoginFormFacebook.self, source: sourceDictionary["facebook"])
                instance.email = Decoders.decodeOptional(clazz: LoginFormEmail.self, source: sourceDictionary["email"])
                return instance
            }


            // Decoder for [LoginFormEmail]
            Decoders.addDecoder(clazz: [LoginFormEmail].self) { (source: AnyObject) -> [LoginFormEmail] in
                return Decoders.decode(clazz: [LoginFormEmail].self, source: source)
            }
            // Decoder for LoginFormEmail
            Decoders.addDecoder(clazz: LoginFormEmail.self) { (source: AnyObject) -> LoginFormEmail in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = LoginFormEmail()
                instance.emailAddress = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email_address"])
                instance.password = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["password"])
                return instance
            }


            // Decoder for [LoginFormFacebook]
            Decoders.addDecoder(clazz: [LoginFormFacebook].self) { (source: AnyObject) -> [LoginFormFacebook] in
                return Decoders.decode(clazz: [LoginFormFacebook].self, source: source)
            }
            // Decoder for LoginFormFacebook
            Decoders.addDecoder(clazz: LoginFormFacebook.self) { (source: AnyObject) -> LoginFormFacebook in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = LoginFormFacebook()
                instance.accessToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["access_token"])
                instance.authCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["auth_code"])
                return instance
            }


            // Decoder for [Message]
            Decoders.addDecoder(clazz: [Message].self) { (source: AnyObject) -> [Message] in
                return Decoders.decode(clazz: [Message].self, source: source)
            }
            // Decoder for Message
            Decoders.addDecoder(clazz: Message.self) { (source: AnyObject) -> Message in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Message()
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                instance.messageType = Message.MessageType(rawValue: (sourceDictionary["message_type"] as? String) ?? "") 
                instance.recipient = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["recipient"])
                instance.sender = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["sender"])
                instance.timestamp = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["timestamp"])
                return instance
            }


            // Decoder for [MessageForm]
            Decoders.addDecoder(clazz: [MessageForm].self) { (source: AnyObject) -> [MessageForm] in
                return Decoders.decode(clazz: [MessageForm].self, source: source)
            }
            // Decoder for MessageForm
            Decoders.addDecoder(clazz: MessageForm.self) { (source: AnyObject) -> MessageForm in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = MessageForm()
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                return instance
            }


            // Decoder for [PasswordForm]
            Decoders.addDecoder(clazz: [PasswordForm].self) { (source: AnyObject) -> [PasswordForm] in
                return Decoders.decode(clazz: [PasswordForm].self, source: source)
            }
            // Decoder for PasswordForm
            Decoders.addDecoder(clazz: PasswordForm.self) { (source: AnyObject) -> PasswordForm in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = PasswordForm()
                instance.password = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["password"])
                return instance
            }


            // Decoder for [PrivateUser]
            Decoders.addDecoder(clazz: [PrivateUser].self) { (source: AnyObject) -> [PrivateUser] in
                return Decoders.decode(clazz: [PrivateUser].self, source: source)
            }
            // Decoder for PrivateUser
            Decoders.addDecoder(clazz: PrivateUser.self) { (source: AnyObject) -> PrivateUser in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = PrivateUser()
                instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"])
                instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"])
                instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"])
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                instance.bio = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["bio"])
                instance.dob = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["dob"])
                instance.education = Decoders.decodeOptional(clazz: Education.self, source: sourceDictionary["education"])
                instance.employment = Decoders.decodeOptional(clazz: Employment.self, source: sourceDictionary["employment"])
                instance.gender = PrivateUser.Gender(rawValue: (sourceDictionary["gender"] as? String) ?? "") 
                instance.isSingle = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["is_single"])
                instance.location = Decoders.decodeOptional(clazz: Location.self, source: sourceDictionary["location"])
                instance.matchWithGender = PrivateUser.MatchWithGender(rawValue: (sourceDictionary["match_with_gender"] as? String) ?? "") 
                instance.matchmakers = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["matchmakers"])
                instance.singles = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["singles"])
                instance.emailAddress = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email_address"])
                instance.password = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["password"])
                return instance
            }


            // Decoder for [SessionKey]
            Decoders.addDecoder(clazz: [SessionKey].self) { (source: AnyObject) -> [SessionKey] in
                return Decoders.decode(clazz: [SessionKey].self, source: source)
            }
            // Decoder for SessionKey
            Decoders.addDecoder(clazz: SessionKey.self) { (source: AnyObject) -> SessionKey in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = SessionKey()
                instance.key = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["key"])
                return instance
            }


            // Decoder for [Status]
            Decoders.addDecoder(clazz: [Status].self) { (source: AnyObject) -> [Status] in
                return Decoders.decode(clazz: [Status].self, source: source)
            }
            // Decoder for Status
            Decoders.addDecoder(clazz: Status.self) { (source: AnyObject) -> Status in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Status()
                instance.status = Status.Status(rawValue: (sourceDictionary["status"] as? String) ?? "") 
                return instance
            }


            // Decoder for [SubscriptionMetadata]
            Decoders.addDecoder(clazz: [SubscriptionMetadata].self) { (source: AnyObject) -> [SubscriptionMetadata] in
                return Decoders.decode(clazz: [SubscriptionMetadata].self, source: source)
            }
            // Decoder for SubscriptionMetadata
            Decoders.addDecoder(clazz: SubscriptionMetadata.self) { (source: AnyObject) -> SubscriptionMetadata in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = SubscriptionMetadata()
                instance.deviceToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_token"])
                return instance
            }


            // Decoder for [User]
            Decoders.addDecoder(clazz: [User].self) { (source: AnyObject) -> [User] in
                return Decoders.decode(clazz: [User].self, source: source)
            }
            // Decoder for User
            Decoders.addDecoder(clazz: User.self) { (source: AnyObject) -> User in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = User()
                instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"])
                instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"])
                instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"])
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                instance.bio = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["bio"])
                instance.dob = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["dob"])
                instance.education = Decoders.decodeOptional(clazz: Education.self, source: sourceDictionary["education"])
                instance.employment = Decoders.decodeOptional(clazz: Employment.self, source: sourceDictionary["employment"])
                instance.gender = User.Gender(rawValue: (sourceDictionary["gender"] as? String) ?? "") 
                instance.isSingle = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["is_single"])
                instance.location = Decoders.decodeOptional(clazz: Location.self, source: sourceDictionary["location"])
                instance.matchWithGender = User.MatchWithGender(rawValue: (sourceDictionary["match_with_gender"] as? String) ?? "") 
                instance.matchmakers = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["matchmakers"])
                instance.singles = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["singles"])
                return instance
            }


            // Decoder for [UserForm]
            Decoders.addDecoder(clazz: [UserForm].self) { (source: AnyObject) -> [UserForm] in
                return Decoders.decode(clazz: [UserForm].self, source: source)
            }
            // Decoder for UserForm
            Decoders.addDecoder(clazz: UserForm.self) { (source: AnyObject) -> UserForm in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = UserForm()
                instance.fbAccessToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fb_access_token"])
                instance.fbAuthCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fb_auth_code"])
                instance.user = Decoders.decodeOptional(clazz: PrivateUser.self, source: sourceDictionary["user"])
                return instance
            }


            // Decoder for [UserName]
            Decoders.addDecoder(clazz: [UserName].self) { (source: AnyObject) -> [UserName] in
                return Decoders.decode(clazz: [UserName].self, source: source)
            }
            // Decoder for UserName
            Decoders.addDecoder(clazz: UserName.self) { (source: AnyObject) -> UserName in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = UserName()
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                return instance
            }
        }
    }
}