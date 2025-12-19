class DetailUser {
	final String id;
	final String username;
	final String email;
	final String name;
	final String? phoneNumber;
	final String? universityName;
	final String? universityBriefName;
	final DateTime createdAt;

	const DetailUser(
		this.id,
		this.username,
		this.email,
		this.name,
		this.phoneNumber,
		this.universityName,
		this.universityBriefName,
		this.createdAt,
	);
}
