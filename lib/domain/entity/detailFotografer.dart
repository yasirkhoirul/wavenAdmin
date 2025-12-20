
class DetailFotografer {
	final String id;
	final String username;
	final String email;
	final String name;
	final String? phoneNumber;
	final String? accountNumber;
	final String? bankAccount;
	final bool isActive;
	final String? gear;
	final int? feePerHour;
	final DateTime createdAt;

	const DetailFotografer(
		this.id,
		this.username,
		this.email,
		this.name,
		this.phoneNumber,
		this.accountNumber,
		this.bankAccount,
		this.isActive,
		this.gear,
		this.feePerHour,
		this.createdAt,
	);
}
