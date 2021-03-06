=head1 NAME

Win32::Word::Writer::TableVisible - Add tables to Word documents.

=head1 SYNOPSIS

Used by the Win32::Word::Writer module.


=cut
package Win32::Word::Writer::TableVisible;

use warnings;
use strict;





our $VERSION = '0.01';





use strict;
use Win32::OLE::Const;
use Data::Dumper;


=head1 PROPERTIES

=head2 oWriter

Win32::Word::Writer::TableVisible object to write to.


=head2 alreadyCreatedRow

Whether a row have been created already.

Default: 0


=head2 createdColumnCount

The number of columns actually created in the table.

Default: 0


=head2 columnPos

Which column we're adding text to currently

=cut
use Class::MethodMaker new_with_init => "new", get_set => [ qw(
	oWriter
	alreadyCreatedRow
	createdColumnCount
	columnPos
)];





=head2 new(oWriter => Win32::Word::Writer $oWriter)

Create new table writer for $oWriter.


=head2 init()

Init the object after creation.


=cut
sub init {
	my $self = shift;
	my (%hParam) = @_;

	$self->createdColumnCount(0);
	$self->columnPos(0);
	$self->alreadyCreatedRow(0);
	$self->oWriter( $hParam{oWriter} ) or die(__PACKAGE__ . "->new() requires an oWriter parameter\n");

	return;
}





=head2 ColumnBegin()

Begin a new column in the row. Existing columns are implicitly closed
first.

=cut
sub ColumnBegin {
	my $self = shift;

	if($self->columnPos > 0) {
		if($self->columnPos < $self->createdColumnCount) {
			$self->oWriter->oSelection->MoveRight( { Unit => $self->oWriter->rhConst->{wdCell} } );
		} else {
			$self->oWriter->oSelection->InsertColumnsRight();
			$self->createdColumnCount( $self->createdColumnCount + 1 );
		}
	}
	
	$self->columnPos( $self->columnPos + 1 );

	return(1);
}





sub _privateTableMethod {
    my $self = shift;
    return "This is outside the project, when looking from project-lib";
}




=head1 AUTHOR

Johan Lindstr�m, C<< <johanl[�T]DarSerMan.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-win32-word-document-writer@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Win32-Word-Document>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2005 Johan Lindstr�m, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut





1;





__END__
