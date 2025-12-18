class DetailAdmin {
	final String id;
	final String username;
	final String email;
	final String name;
	final String? phoneNumber;
	final bool isActive;
	final DateTime createdAt;

	const DetailAdmin(
		this.id,
		this.username,
		this.email,
		this.name,
		this.phoneNumber,
		this.isActive,
		this.createdAt,
	);
}
