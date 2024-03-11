

import Foundation

struct Instructions: Identifiable {
    var id = UUID()
    var name: String
    var description: String
}

let instructionsList = [
Instructions(name: "Обыск", description: "  Основанием производства обыска является наличие достаточных данных полагать, что в каком-либо месте или у какого-либо лица могут находиться орудия, оборудование или иные средства совершения преступления, предметы, документы и ценности, которые могут иметь значение для уголовного дела. \nОбыск производится на основании постановления следователя. \n  Обыск в жилище производится на основании судебного решения. До начала обыска следователь предъявляет постановление о его производстве, а в случаях обыска в жилище- судебное решение, разрешающее его производство. \n  До начала обыска следователь предлагает добровольно выдать подлежащие изъятию предметы, документы и ценности, которые могут иметь значение для уголовного дела. Если они выданы добровольно и нет оснований опасаться их сокрытия, то следователь вправе не производить обыск. \n  При производстве обыска могут вскрываться любые помещения, если владелец отказывается добровольно их открыть. При этом не должно допускаться не вызываемое необходимостью повреждение имущества. \n  Следователь принимает меры к тому, чтобы не были оглашены выявленные в ходе обыска обстоятельства частной жизни лица, в помещении которого был произведен обыск, его личная и (или) семейная тайна, а также обстоятельства частной жизни других лиц. Следователь вправе запретить лицам, присутствующим в месте, где производится обыск, покидать его, а также общаться друг с другом или иными лицами до окончания обыска. \n  При производстве обыска во всяком случае изымаются предметы и документы, изъятые из оборота. \n  Изъятые предметы, документы и ценности предъявляются понятым и другим лицам, присутствующим при обыске, и в случае необходимости упаковываются и опечатываются на месте обыска, что удостоверяется подписями указанных лиц. \n  При производстве обыска участвуют лицо, в помещении которого производится обыск, либо совершеннолетние члены его семьи. При производстве обыска вправе присутствовать защитник, а также адвокат того лица, в помещении которого производится обыск. \nПри производстве обыска составляется протокол в соответствии со статьями 166 и 167 Уголовно-процессуального кодекса. В протоколе должно быть указано, в каком месте и при каких обстоятельствах были обнаружены предметы, документы или ценности, выданы они добровольно или изъяты принудительно. \n  Все изымаемые предметы, документы и ценности должны быть перечислены с точным указанием их количества, меры, веса, индивидуальных признаков и по возможности стоимости. \n  Если в ходе обыска были предприняты попытки уничтожить или спрятать подлежащие изъятию предметы, документы или ценности, то об этом в протоколе делается соответствующая запись и указываются принятые меры. Копия протокола вручается лицу, в помещении которого был произведен обыск, либо совершеннолетнему члену его семьи. \n  Если обыск производился в помещении организации, то копия протокола вручается под расписку представителю администрации соответствующей организации. Обыск может производиться и в целях обнаружения разыскиваемых лиц и трупов.  \n  Если вам необходима консультация, вы можете прямо сейчас отправить запрос на звонок адвоката"),
Instructions(name: "Задержание", description: "Орган дознания, дознаватель, следователь вправе задержать лицо по подозрению в совершении преступления, за которое может быть назначено наказание в виде лишения свободы, при наличии одного из следующих оснований:\n 1) когда это лицо застигнуто при совершении преступления или непосредственно после его совершения; \n 2) когда потерпевшие или очевидцы укажут на данное лицо как на совершившее преступление;\n  3) когда на этом лице или его одежде, при нем или в его жилище будут обнаружены явные следы преступления.\n   При наличии иных данных, дающих основание подозревать лицо в совершении преступления, оно может быть задержано, если это лицо пыталось скрыться, либо не имеет постоянного места жительства, либо не установлена его личность, либо если следователем с согласия руководителя следственного органа или дознавателем с согласия прокурора в суд направлено ходатайство об избрании в отношении указанного лица меры пресечения в виде заключения под стражу. \n  Лицо не может быть задержано по подозрению в совершении преступления, по которому истекли сроки давности уголовного преследования, за исключением случаев, если лицо подозревается или обвиняется в совершении преступления, наказуемого смертной казнью или пожизненным лишением свободы. "),
Instructions(name: "Личный досмотр", description: "\n 1. Личный досмотр, досмотр вещей, находящихся при физическом лице, то есть обследование вещей, проводимое без нарушения их конструктивной целостности, осуществляются в случае необходимости в целях обнаружения орудий совершения либо предметов административного правонарушения.\n  2. Личный досмотр, досмотр вещей, находящихся при физическом лице, осуществляются должностными лицами.\n  3. Личный досмотр производится лицом одного пола с досматриваемым в присутствии двух понятых того же пола.\n  Досмотр вещей, находящихся при физическом лице (ручной клади, багажа, орудий охоты и рыболовства, добытой продукции и иных предметов), осуществляется уполномоченными на то должностными лицами в присутствии двух понятых либо с применением видеозаписи.\n  4. В исключительных случаях при наличии достаточных оснований полагать, что при физическом лице находятся оружие или иные предметы, используемые в качестве оружия, личный досмотр, досмотр вещей, находящихся при физическом лице, могут быть осуществлены без понятых.\n  5. В случае необходимости применяются фото- и киносъемка, иные установленные способы фиксации вещественных доказательств.\n  6. О личном досмотре, досмотре вещей, находящихся при физическом лице, составляется протокол либо делается соответствующая запись в протоколе о доставлении или в протоколе об административном задержании. В протоколе о личном досмотре, досмотре вещей, находящихся при физическом лице, указываются дата и место его составления, должность, фамилия и инициалы лица, составившего протокол, сведения о физическом лице, подвергнутом личному досмотру, о виде, количестве, об иных идентификационных признаках вещей, в том числе о типе, марке, модели, калибре, серии, номере, об иных идентификационных признаках оружия, о виде и количестве боевых припасов, о виде и реквизитах документов, обнаруженных при досмотре, находящихся при физическом лице.\n  7. В протоколе о личном досмотре, досмотре вещей, находящихся при физическом лице, делается запись о применении фото- и киносъемки, иных установленных способов фиксации вещественных доказательств. Материалы, полученные при осуществлении личного досмотра, досмотра вещей, находящихся при физическом лице, с применением фото- и киносъемки, иных установленных способов фиксации вещественных доказательств, прилагаются к соответствующему протоколу.\n  8. Протокол о личном досмотре, досмотре вещей, находящихся при физическом лице, подписывается должностным лицом, его составившим, лицом, в отношении которого ведется производство по делу об административном правонарушении, либо владельцем вещей, подвергнутых досмотру, понятыми в случае их участия. В случае отказа лица, в отношении которого ведется производство по делу, владельца вещей, подвергнутых досмотру, от подписания протокола в нем делается соответствующая запись. Копия протокола о личном досмотре, досмотре вещей, находящихся при физическом лице, вручается владельцу вещей, подвергнутых досмотру, по его просьбе."),
Instructions(name: "Допрос", description: "  1. Перед допросом следователь удостоверяется в личности допрашиваемого лица. Если у следователя возникают сомнения, владеет ли допрашиваемое лицо языком, на котором ведется производство по уголовному делу, то он выясняет, на каком языке допрашиваемое лицо желает давать показания.\n  2. Задавать наводящие вопросы запрещается. В остальном следователь свободен при выборе тактики допроса.\n  3. Допрашиваемое лицо вправе пользоваться документами и записями.\n  4. По инициативе следователя или по ходатайству допрашиваемого лица в ходе допроса могут быть проведены фотографирование, аудио- и (или) видеозапись, киносъемка, материалы которых хранятся при уголовном деле и по окончании предварительного следствия опечатываются.\n  5. Если свидетель явился на допрос с адвокатом, приглашенным им для оказания юридической помощи, то адвокат присутствует при допросе и пользуется правами, предусмотренными частью второй статьи 53 настоящего Кодекса. По окончании допроса адвокат вправе делать заявления о нарушениях прав и законных интересов свидетеля. Указанные заявления подлежат занесению в протокол допроса.")

]
