part of values;

class Shadows {
  static const dishCard = const BoxShadow(
    color: AppColors.white200,
    offset: const Offset(0, Sizes.SIZE_30),
    blurRadius: Sizes.SIZE_60,
  );

  static const authHeader = const BoxShadow(
    color: AppColors.black6,
    offset: const Offset(0, 4.0),
    blurRadius: Sizes.SIZE_30,
  );

  static const container = const BoxShadow(
    color: AppColors.white200,
    offset: Offset(0.0, 40.0),
    blurRadius: Sizes.SIZE_40,
  );

  static const infoCard = const BoxShadow(
    color: AppColors.black3,
    offset: Offset(0.0, 10.0),
    blurRadius: Sizes.SIZE_40,
  );
}
