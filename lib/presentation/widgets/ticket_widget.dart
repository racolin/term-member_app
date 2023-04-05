import 'package:flutter/material.dart';

import '../../data/models/ticket_model.dart';
import '../../supports/convert.dart';
import '../clippers/ticket_clipper.dart';
import '../res/dimen/dimens.dart';

class TicketWidget extends StatelessWidget {
  final TicketModel ticket;
  final bool? back;

  const TicketWidget({
    Key? key,
    required this.ticket,
    this.back = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (back ?? true) {
          Navigator.pop(context, ticket);
        } else {

        }
      },
      child: ClipPath(
        clipper: TicketClipper(numberOfSmall: 8, ticketRate: 2 / 7),
        child: Container(
          height: 100,
          color: Colors.white70,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(spaceSM),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(spaceXS),
                    child: Image.network(
                      ticket.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(spaceMD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        dateToString(ticket.expire, 'dd/MM/yyyy'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
