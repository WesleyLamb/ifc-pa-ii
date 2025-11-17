import 'package:flutter/material.dart';
import 'package:app/ui/components/colors/app_colors.dart';
import 'package:app/models/kid.dart';
import 'package:app/ui/pages/edit_kid_page.dart';


class KidCard extends StatelessWidget {
  final Kid kid;
  final VoidCallback? onTap;

  const KidCard({
    Key? key,
    required this.kid,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.light.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: onTap ?? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditKidPage(kidId: kid.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar com iniciais
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.accent.withOpacity(0.2),
                child: Text(
                  kid.iniciais,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Informações do aluno
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome
                    Text(
                      kid.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Matrícula
                    Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          size: 14,
                          color: AppColors.dark.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Mat: ${kid.libraryIdentifier}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Idade e Turno
                    Row(
                      children: [
                        Icon(
                          Icons.cake_outlined,
                          size: 14,
                          color: AppColors.dark.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          kid.idade > 1
                              ? '${kid.idade} anos'
                              : kid.idade == 1
                                  ? '${kid.idade} ano'
                                  : '${kid.idadeEmMeses} meses',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.wb_sunny_outlined,
                          size: 14,
                          color: AppColors.dark.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          kid.turnoFormatado,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Turmas
                    if (kid.classes.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: kid.classes.map<Widget>((cls) {
                          if (cls is Map<String, dynamic>) {
                            final className = cls['name'] ?? 'Sem nome';
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.class_outlined,
                                    size: 12,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    className,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }).toList(),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.light.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Sem turma',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Ícone de seta
              const Icon(
                Icons.chevron_right,
                color: AppColors.light,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
