module JsonWebToken
	SECRET_KEY = 'secret'

	def self.encode(payload, exp = 24.hours.from_now)
		payload[:exp] = exp.to_i
		JWT.encode(payload, SECRET_KEY)
	end

	def self.decode(token)
		decode = JWT.decode(token, SECRET_KEY)[0]
		HashWithIndifferentAccess.new decoded
	end
end